import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'dart:convert'; // Necessário para ler o JSON
import '../database/database.dart';

// --- DTOs ATUALIZADOS ---

class MuscleGroupHistoryDTO {
  final String groupName;
  final String color;
  final List<ExerciseHistorySummaryDTO> exercises;

  MuscleGroupHistoryDTO({
    required this.groupName,
    required this.color,
    required this.exercises,
  });
}

class ExerciseHistorySummaryDTO {
  final String exerciseName;
  final List<ExerciseRecordDTO> records;

  ExerciseHistorySummaryDTO({
    required this.exerciseName,
    required this.records,
  });
}

// Classe para cada série individual
class SetHistoryItemDTO {
  final String performance; // Ex: "10x 20kg"
  final String? feedbackSummary; // Ex: "Ideal • Pump Alto"
  final bool hasLimiters; // Para mudar a cor se houve dor/limitação

  SetHistoryItemDTO({
    required this.performance,
    this.feedbackSummary,
    this.hasLimiters = false,
  });
}

class ExerciseRecordDTO {
  final DateTime date;
  final double maxWeight;
  final double totalVolume;
  final List<SetHistoryItemDTO> sets; // <--- ALTERADO DE LIST<STRING> PARA LIST<OBJETO>

  ExerciseRecordDTO({
    required this.date,
    required this.maxWeight,
    required this.totalVolume,
    required this.sets,
  });
}

class WorkoutProvider extends ChangeNotifier {
  final AppDatabase database;
  
  // Variáveis do treino ativo
  WorkoutSession? _currentWorkout;
  Exercise? _currentExercise;
  int _currentSeriesIndex = 0;
  bool _isIntervalActive = false;
  int _remainingIntervalSeconds = 0;

  WorkoutProvider(this.database);

  WorkoutSession? get currentWorkout => _currentWorkout;
  Exercise? get currentExercise => _currentExercise;
  int get currentSeriesIndex => _currentSeriesIndex;
  bool get isIntervalActive => _isIntervalActive;
  int get remainingIntervalSeconds => _remainingIntervalSeconds;

  // --- MÉTODOS DE TREINO ATIVO (MANTIDOS IGUAIS) ---
  
  Future<void> startWorkout(String trainingSessionId, String sessionMuscleGroupId) async {
    _currentWorkout = WorkoutSession(
      id: const Uuid().v4(),
      trainingSessionId: trainingSessionId,
      sessionMuscleGroupId: sessionMuscleGroupId,
      startedAt: DateTime.now(),
      completedAt: null,
      isCompleted: false,
    );
    await database.insertWorkoutSession(_currentWorkout!);
    _currentSeriesIndex = 0;
    notifyListeners();
  }

  Future<void> setCurrentExercise(Exercise exercise) async {
    _currentExercise = exercise;
    _currentSeriesIndex = 0;
    notifyListeners();
  }

  Future<void> completeExerciseSeries(String seriesId, int? actualReps, double? weightKg) async {
    await database.updateExerciseSeriesWithData(seriesId, actualReps, weightKg);
    _currentSeriesIndex++;
    notifyListeners();
  }

  void startInterval(int seconds) {
    _isIntervalActive = true;
    _remainingIntervalSeconds = seconds;
    notifyListeners();
  }

  void updateIntervalTime(int remainingSeconds) {
    _remainingIntervalSeconds = remainingSeconds;
    if (remainingSeconds <= 0) _isIntervalActive = false;
    notifyListeners();
  }

  void stopInterval() {
    _isIntervalActive = false;
    _remainingIntervalSeconds = 0;
    notifyListeners();
  }

  Future<void> finishWorkout(int completedSeries) async {
    // Lógica antiga de finalizar, mantida para compatibilidade
    if (_currentWorkout != null && _currentExercise != null) {
      final updated = _currentWorkout!.copyWith(
        completedAt: Value(_currentWorkout!.completedAt ?? DateTime.now()),
        isCompleted: true,
      );
      await database.updateWorkoutSession(updated);
      final history = WorkoutHistory(
        id: const Uuid().v4(),
        workoutSessionId: _currentWorkout!.id,
        exerciseId: _currentExercise!.id,
        completedSeries: completedSeries,
        maxWeightKg: null,
        totalVolumeLoad: 0.0,
        completedAt: DateTime.now(),
      );
      await database.insertWorkoutHistory(history);
      _currentWorkout = null;
      _currentExercise = null;
      _currentSeriesIndex = 0;
      notifyListeners();
    }
  }

  void reset() {
    _currentWorkout = null;
    _currentExercise = null;
    _currentSeriesIndex = 0;
    _isIntervalActive = false;
    _remainingIntervalSeconds = 0;
    notifyListeners();
  }

  // --- BUSCA DE HISTÓRICO COM PARSER DE FEEDBACK ---
  
  Future<List<MuscleGroupHistoryDTO>> getHistoryOrganizedByGroup() async {
    final query = database.select(database.workoutHistories).join([
      innerJoin(
        database.exercises,
        database.exercises.id.equalsExp(database.workoutHistories.exerciseId),
      ),
      innerJoin(
        database.workoutSessions, 
        database.workoutSessions.id.equalsExp(database.workoutHistories.workoutSessionId),
      ),
      innerJoin(
        database.sessionMuscleGroups,
        database.sessionMuscleGroups.id.equalsExp(database.workoutSessions.sessionMuscleGroupId),
      ),
      innerJoin(
        database.muscleGroups,
        database.muscleGroups.id.equalsExp(database.sessionMuscleGroups.muscleGroupId),
      ),
    ])
      ..orderBy([OrderingTerm(expression: database.workoutHistories.completedAt, mode: OrderingMode.desc)]);

    final rows = await query.get();

    final Map<String, Map<String, List<ExerciseRecordDTO>>> groupedData = {};
    final Map<String, String> groupColors = {};

    for (var row in rows) {
      final history = row.readTable(database.workoutHistories);
      final exercise = row.readTable(database.exercises);
      final muscleGroup = row.readTable(database.muscleGroups);
      final date = history.completedAt;

      // Buscar detalhes das séries (Sets)
      final sets = await database.getSetsForHistory(history.id);
      
      // --- LÓGICA DE PARSEAMENTO DO FEEDBACK ---
      final List<SetHistoryItemDTO> setDetails = sets.map((s) {
        String performance = "${s.reps}x ${s.weightKg.toStringAsFixed(1).replaceAll('.0', '')}kg";
        String? feedbackText;
        bool limitersPresent = false;

        if (s.feedback != null && s.feedback!.isNotEmpty) {
          try {
            final Map<String, dynamic> json = jsonDecode(s.feedback!);
            
            List<String> parts = [];
            
            // 1. Progressão (Leve, Ideal, Pesado...)
            if (json['progression'] != null) {
              parts.add(json['progression']);
            }

            // 2. Limitadores (Dor, Falha...)
            if (json['limiters'] != null && (json['limiters'] as List).isNotEmpty) {
              final limits = (json['limiters'] as List).join(', ');
              parts.add("Lim: $limits");
              limitersPresent = true; // Marca para destacar visualmente
            }

            // 3. Sensações (Pump, etc)
            if (json['sensations'] != null && (json['sensations'] as List).isNotEmpty) {
              final senses = (json['sensations'] as List).join(', ');
              parts.add(senses);
            }

            if (parts.isNotEmpty) {
              feedbackText = parts.join(' • ');
            }
          } catch (e) {
            // Erro ao ler JSON, ignora
          }
        }

        return SetHistoryItemDTO(
          performance: performance,
          feedbackSummary: feedbackText,
          hasLimiters: limitersPresent,
        );
      }).toList();

      final record = ExerciseRecordDTO(
        date: date,
        maxWeight: history.maxWeightKg ?? 0.0,
        totalVolume: history.totalVolumeLoad,
        sets: setDetails,
      );

      if (!groupedData.containsKey(muscleGroup.name)) {
        groupedData[muscleGroup.name] = {};
        groupColors[muscleGroup.name] = muscleGroup.color;
      }

      if (!groupedData[muscleGroup.name]!.containsKey(exercise.name)) {
        groupedData[muscleGroup.name]![exercise.name] = [];
      }

      groupedData[muscleGroup.name]![exercise.name]!.add(record);
    }

    final List<MuscleGroupHistoryDTO> result = [];

    groupedData.forEach((groupName, exercisesMap) {
      final List<ExerciseHistorySummaryDTO> exerciseList = [];

      exercisesMap.forEach((exerciseName, records) {
        final limitedRecords = records.take(10).toList();
        exerciseList.add(ExerciseHistorySummaryDTO(
          exerciseName: exerciseName,
          records: limitedRecords,
        ));
      });

      result.add(MuscleGroupHistoryDTO(
        groupName: groupName,
        color: groupColors[groupName] ?? '#FFFFFF',
        exercises: exerciseList,
      ));
    });

    return result;
  }
}

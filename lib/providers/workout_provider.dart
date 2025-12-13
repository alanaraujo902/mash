import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'dart:convert';
import '../database/database.dart';

// --- DTOs HIERÁRQUICOS ---

class HistorySessionDTO {
  final String sessionName;
  final List<HistoryMuscleGroupDTO> muscleGroups;

  HistorySessionDTO({required this.sessionName, required this.muscleGroups});
}

class HistoryMuscleGroupDTO {
  final String groupName;
  final String color;
  final List<HistoryExerciseDTO> exercises;

  HistoryMuscleGroupDTO({required this.groupName, required this.color, required this.exercises});
}

class HistoryExerciseDTO {
  final String exerciseName;
  final List<ExerciseRecordDTO> records;

  HistoryExerciseDTO({required this.exerciseName, required this.records});
}

// Mantido igual ao anterior
class SetHistoryItemDTO {
  final String performance;
  final String? feedbackSummary;
  final bool hasLimiters;

  SetHistoryItemDTO({required this.performance, this.feedbackSummary, this.hasLimiters = false});
}

class ExerciseRecordDTO {
  final DateTime date;
  final double maxWeight;
  final double totalVolume;
  final List<SetHistoryItemDTO> sets;

  ExerciseRecordDTO({
    required this.date,
    required this.maxWeight,
    required this.totalVolume,
    required this.sets,
  });
}

class WorkoutProvider extends ChangeNotifier {
  final AppDatabase database;
  
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

  // --- MÉTODOS DE TREINO ATIVO (Mantidos) ---
  
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

  // --- NOVA BUSCA HIERÁRQUICA COMPLETA ---
  // Sessão -> Grupo -> Exercício -> Registros
  
  Future<List<HistorySessionDTO>> getFullHierarchicalHistory() async {
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
        database.trainingSessions, // Importante: Join com Sessão de Treino
        database.trainingSessions.id.equalsExp(database.workoutSessions.trainingSessionId),
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

    // Mapas aninhados: Session -> MuscleGroup -> Exercise -> List<Records>
    final Map<String, Map<String, Map<String, List<ExerciseRecordDTO>>>> tree = {};
    
    // Metadados para reconstruir os nomes/cores
    final Map<String, String> sessionNames = {};
    final Map<String, String> groupNames = {};
    final Map<String, String> groupColors = {};
    final Map<String, String> exerciseNames = {};

    for (var row in rows) {
      final history = row.readTable(database.workoutHistories);
      final exercise = row.readTable(database.exercises);
      final session = row.readTable(database.trainingSessions);
      final group = row.readTable(database.muscleGroups);
      final date = history.completedAt;

      // Salva metadados
      sessionNames[session.id] = session.name;
      groupNames[group.id] = group.name;
      groupColors[group.id] = group.color;
      exerciseNames[exercise.id] = exercise.name;

      // Processa os sets
      final sets = await database.getSetsForHistory(history.id);
      final List<SetHistoryItemDTO> setDetails = sets.map((s) {
        String performance = "${s.reps}x ${s.weightKg.toStringAsFixed(1).replaceAll('.0', '')}kg";
        String? feedbackText;
        bool limitersPresent = false;

        if (s.feedback != null && s.feedback!.isNotEmpty) {
          try {
            final Map<String, dynamic> json = jsonDecode(s.feedback!);
            List<String> parts = [];
            if (json['progression'] != null) parts.add(json['progression']);
            if (json['limiters'] != null && (json['limiters'] as List).isNotEmpty) {
              final limits = (json['limiters'] as List).join(', ');
              parts.add("Lim: $limits");
              limitersPresent = true;
            }
            if (json['sensations'] != null && (json['sensations'] as List).isNotEmpty) {
              final senses = (json['sensations'] as List).join(', ');
              parts.add(senses);
            }
            if (parts.isNotEmpty) feedbackText = parts.join(' • ');
          } catch (_) {}
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

      // Constrói a árvore
      tree.putIfAbsent(session.id, () => {});
      tree[session.id]!.putIfAbsent(group.id, () => {});
      tree[session.id]![group.id]!.putIfAbsent(exercise.id, () => []);
      
      tree[session.id]![group.id]![exercise.id]!.add(record);
    }

    // Converter Maps para DTOs
    final List<HistorySessionDTO> result = [];

    tree.forEach((sessionId, groupsMap) {
      final List<HistoryMuscleGroupDTO> muscleGroupDTOs = [];

      groupsMap.forEach((groupId, exercisesMap) {
        final List<HistoryExerciseDTO> exerciseDTOs = [];

        exercisesMap.forEach((exerciseId, records) {
          // Limita a 10 registros
          exerciseDTOs.add(HistoryExerciseDTO(
            exerciseName: exerciseNames[exerciseId] ?? 'Unknown',
            records: records.take(10).toList(),
          ));
        });

        muscleGroupDTOs.add(HistoryMuscleGroupDTO(
          groupName: groupNames[groupId] ?? 'Unknown',
          color: groupColors[groupId] ?? '#FFFFFF',
          exercises: exerciseDTOs,
        ));
      });

      result.add(HistorySessionDTO(
        sessionName: sessionNames[sessionId] ?? 'Unknown',
        muscleGroups: muscleGroupDTOs,
      ));
    });

    return result;
  }
}
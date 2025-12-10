import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

// --- NOVOS DTOs PARA A NOVA VISUALIZAÇÃO ---

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

class ExerciseRecordDTO {
  final DateTime date;
  final double maxWeight;
  final double totalVolume;
  final List<String> setDetails; // Ex: "10x 20kg"

  ExerciseRecordDTO({
    required this.date,
    required this.maxWeight,
    required this.totalVolume,
    required this.setDetails,
  });
}

// Classe auxiliar para facilitar a exibição na UI (mantida para compatibilidade)
class WorkoutSessionHistoryDTO {
  final String sessionId;
  final DateTime date;
  final String sessionName; // Ex: "Treino A"
  final String groupName;   // Ex: "Peito"
  final List<WorkoutExerciseHistoryDTO> exercises;

  WorkoutSessionHistoryDTO({
    required this.sessionId,
    required this.date,
    required this.sessionName,
    required this.groupName,
    required this.exercises,
  });
}

class WorkoutExerciseHistoryDTO {
  final String exerciseName;
  final int seriesCount;
  final double maxWeight;
  final double totalVolume;
  final List<String> setDetails; // <--- NOVO CAMPO

  WorkoutExerciseHistoryDTO({
    required this.exerciseName,
    required this.seriesCount,
    required this.maxWeight,
    required this.totalVolume,
    required this.setDetails, // <--- NOVO
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

  // --- MÉTODOS DE TREINO ATIVO (Start, Update, Finish) MANTIDOS ---
  
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

  // --- NOVA LÓGICA DE BUSCA AGRUPADA ---
  
  Future<List<MuscleGroupHistoryDTO>> getHistoryOrganizedByGroup() async {
    // 1. Query principal: Busca todo o histórico com os joins necessários
    final query = database.select(database.workoutHistories).join([
      innerJoin(
        database.exercises,
        database.exercises.id.equalsExp(database.workoutHistories.exerciseId),
      ),
      innerJoin(
        database.workoutSessions, // Necessário para saber a data real do treino
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

    // Mapas temporários para agrupar os dados
    // Estrutura: { 'MuscleGroupName': { 'ExerciseName': [List of Records] } }
    final Map<String, Map<String, List<ExerciseRecordDTO>>> groupedData = {};
    final Map<String, String> groupColors = {};

    for (var row in rows) {
      final history = row.readTable(database.workoutHistories);
      final exercise = row.readTable(database.exercises);
      final muscleGroup = row.readTable(database.muscleGroups);
      // Usamos a data da sessão ou do histórico
      final date = history.completedAt;

      // Buscar detalhes das séries (Sets)
      final sets = await database.getSetsForHistory(history.id);
      final setDetails = sets.map((s) {
        return "${s.reps}x ${s.weightKg.toStringAsFixed(1).replaceAll('.0', '')}kg";
      }).toList();

      final record = ExerciseRecordDTO(
        date: date,
        maxWeight: history.maxWeightKg ?? 0.0,
        totalVolume: history.totalVolumeLoad,
        setDetails: setDetails,
      );

      // Agrupamento
      if (!groupedData.containsKey(muscleGroup.name)) {
        groupedData[muscleGroup.name] = {};
        groupColors[muscleGroup.name] = muscleGroup.color;
      }

      if (!groupedData[muscleGroup.name]!.containsKey(exercise.name)) {
        groupedData[muscleGroup.name]![exercise.name] = [];
      }

      // Adiciona o registro
      groupedData[muscleGroup.name]![exercise.name]!.add(record);
    }

    // Converter Maps para a lista de DTOs final
    final List<MuscleGroupHistoryDTO> result = [];

    groupedData.forEach((groupName, exercisesMap) {
      final List<ExerciseHistorySummaryDTO> exerciseList = [];

      exercisesMap.forEach((exerciseName, records) {
        // LIMITAR AOS ÚLTIMOS 10 TREINOS
        // A query já veio ordenada por data descrescente, então pegamos os primeiros 10
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

  // --- MÉTODO ANTIGO (mantido para compatibilidade, se necessário) ---
  Future<List<WorkoutSessionHistoryDTO>> getFullHistory() async {
    final query = database.select(database.workoutSessions).join([
      innerJoin(
        database.trainingSessions,
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
      ..where(database.workoutSessions.isCompleted.equals(true))
      ..orderBy([OrderingTerm(expression: database.workoutSessions.completedAt, mode: OrderingMode.desc)]);

    final rows = await query.get();
    final List<WorkoutSessionHistoryDTO> history = [];

    for (var row in rows) {
      final workoutSession = row.readTable(database.workoutSessions);
      final trainingSession = row.readTable(database.trainingSessions);
      final muscleGroup = row.readTable(database.muscleGroups);

      // Buscar exercícios (History Pai)
      final historyQuery = database.select(database.workoutHistories).join([
        innerJoin(
          database.exercises,
          database.exercises.id.equalsExp(database.workoutHistories.exerciseId),
        )
      ])..where(database.workoutHistories.workoutSessionId.equals(workoutSession.id));

      final historyRows = await historyQuery.get();
      
      // Mapear os dados
      List<WorkoutExerciseHistoryDTO> exercisesList = [];
      
      for (var hRow in historyRows) {
        final hist = hRow.readTable(database.workoutHistories);
        final exer = hRow.readTable(database.exercises);

        // --- NOVO: BUSCAR OS DETALHES DAS SÉRIES (History Filhos) ---
        final sets = await database.getSetsForHistory(hist.id);
        
        // Formatar: "10x 20kg", "8x 22kg"
        final setsFormatted = sets.map((s) {
           return "${s.reps}x ${s.weightKg.toStringAsFixed(1).replaceAll('.0', '')}kg";
        }).toList();

        exercisesList.add(WorkoutExerciseHistoryDTO(
          exerciseName: exer.name,
          seriesCount: hist.completedSeries,
          maxWeight: hist.maxWeightKg ?? 0.0,
          totalVolume: hist.totalVolumeLoad,
          setDetails: setsFormatted, // <--- ADICIONAR AQUI
        ));
      }

      if (exercisesList.isNotEmpty) {
        history.add(WorkoutSessionHistoryDTO(
          sessionId: workoutSession.id,
          date: workoutSession.completedAt ?? DateTime.now(),
          sessionName: trainingSession.name,
          groupName: muscleGroup.name,
          exercises: exercisesList,
        ));
      }
    }

    return history;
  }
}

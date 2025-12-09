import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

// Classe auxiliar para facilitar a exibição na UI
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

  Future<void> startWorkout(
    String trainingSessionId,
    String sessionMuscleGroupId,
  ) async {
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

  Future<void> completeExerciseSeries(
    String seriesId,
    int? actualReps,
    double? weightKg,
  ) async {
    // Atualizar série
    await database.updateExerciseSeriesWithData(
      seriesId,
      actualReps,
      weightKg,
    );
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
    if (remainingSeconds <= 0) {
      _isIntervalActive = false;
    }
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
        totalVolumeLoad: 0.0, // Valor padrão, pois este método não calcula volume load
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

  // --- NOVO MÉTODO: BUSCAR HISTÓRICO COMPLETO ---
  Future<List<WorkoutSessionHistoryDTO>> getFullHistory() async {
    // 1. Busca todas as sessões de treino concluídas (WorkoutSessions)
    // Precisamos fazer joins para pegar os nomes
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

      // 2. Para cada sessão, buscar os exercícios realizados (WorkoutHistories)
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

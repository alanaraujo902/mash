import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

class ExerciseProvider extends ChangeNotifier {
  final AppDatabase database;
  Map<String, List<Exercise>> _exercisesBySessionMuscleGroup = {};
  Map<String, List<ExerciseSeries>> _exerciseSeriesList = {};
  
  // Cache para histórico
  Map<String, List<WorkoutHistory>> _exerciseHistories = {};

  ExerciseProvider(this.database);

  Future<void> loadExercises(String sessionMuscleGroupId) async {
    _exercisesBySessionMuscleGroup[sessionMuscleGroupId] =
        await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);
    notifyListeners();
  }

  List<Exercise> getExercises(String sessionMuscleGroupId) {
    return _exercisesBySessionMuscleGroup[sessionMuscleGroupId] ?? [];
  }

  Future<void> addExercise(
    String sessionMuscleGroupId,
    String name,
    int plannedSeries,
    int plannedReps,
    int intervalSeconds,
  ) async {
    final currentExercises = getExercises(sessionMuscleGroupId);
    final exercise = Exercise(
      id: const Uuid().v4(),
      sessionMuscleGroupId: sessionMuscleGroupId,
      name: name,
      plannedSeries: plannedSeries,
      plannedReps: plannedReps,
      intervalSeconds: intervalSeconds,
      order: currentExercises.length,
      createdAt: DateTime.now(),
    );

    await database.insertExercise(exercise);

    // Criar séries vazias
    for (int i = 1; i <= plannedSeries; i++) {
      final series = ExerciseSeries(
        id: const Uuid().v4(),
        exerciseId: exercise.id,
        seriesNumber: i,
        actualReps: null,
        weightKg: null,
        completedAt: null,
        isCompleted: false,
      );
      await database.insertExerciseSeries(series);
    }

    await loadExercises(sessionMuscleGroupId);
  }

  Future<void> updateExercise(
    String exerciseId,
    String name,
    int plannedSeries,
    int plannedReps,
    int intervalSeconds,
  ) async {
    // Implementar lógica de atualização
    notifyListeners();
  }

  Future<void> deleteExercise(String exerciseId) async {
    await database.deleteExercise(exerciseId);
    notifyListeners();
  }

  Future<void> loadExerciseSeries(String exerciseId) async {
    _exerciseSeriesList[exerciseId] =
        await database.getExerciseSeriesList(exerciseId);
    notifyListeners();
  }

  List<ExerciseSeries> getExerciseSeries(String exerciseId) {
    return _exerciseSeriesList[exerciseId] ?? [];
  }

  // Métodos para histórico
  Future<void> loadExerciseHistory(String exerciseId) async {
    _exerciseHistories[exerciseId] = 
        await database.getWorkoutHistoryByExercise(exerciseId);
    notifyListeners();
  }

  List<WorkoutHistory> getExerciseHistory(String exerciseId) {
    return _exerciseHistories[exerciseId] ?? [];
  }

  Future<void> updateExerciseSeries(
    String seriesId,
    int? actualReps,
    double? weightKg,
  ) async {
    await database.updateExerciseSeriesWithData(
      seriesId,
      actualReps,
      weightKg,
    );
    notifyListeners();
  }

  Future<void> completeExerciseSeries(String seriesId) async {
    await database.updateExerciseSeriesWithData(
      seriesId,
      null,
      null,
    );
    notifyListeners();
  }

  // Verifica se todas as séries de todos os exercícios do grupo estão concluídas
  Future<bool> checkAllExercisesCompleted(String sessionMuscleGroupId) async {
    // 1. Pega todos os exercícios desse grupo
    final exercises = await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);

    for (var exercise in exercises) {
      // 2. Para cada exercício, pega as séries
      final seriesList = await database.getExerciseSeriesList(exercise.id);

      // 3. Se houver alguma série NÃO completada, retorna falso
      if (seriesList.any((s) => !s.isCompleted)) {
        return false;
      }
    }
    // Se passou por tudo e não retornou false, então tudo está completo
    return true;
  }

  // Finaliza o treino e salva no histórico
  Future<void> finishSessionMuscleGroup(
    String sessionMuscleGroupId,
    String trainingSessionId,
  ) async {
    final now = DateTime.now();

    // 1. Registrar a Sessão Geral
    final workoutSessionId = const Uuid().v4();
    final workoutSession = WorkoutSession(
      id: workoutSessionId,
      trainingSessionId: trainingSessionId,
      sessionMuscleGroupId: sessionMuscleGroupId,
      startedAt: now.subtract(const Duration(hours: 1)),
      completedAt: now,
      isCompleted: true,
    );

    await database.insertWorkoutSession(workoutSession);

    // 2. Processar cada exercício
    final exercises = await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);

    for (var exercise in exercises) {
      final seriesList = await database.getExerciseSeriesList(exercise.id);

      final completedSeries = seriesList.where((s) => s.isCompleted).toList();

      // --- SALVAR HISTÓRICO ---
      if (completedSeries.isNotEmpty) {
        double maxWeight = 0;
        for (var s in completedSeries) {
          if ((s.weightKg ?? 0) > maxWeight) {
            maxWeight = s.weightKg!;
          }
        }

        final history = WorkoutHistory(
          id: const Uuid().v4(),
          workoutSessionId: workoutSessionId,
          exerciseId: exercise.id,
          completedSeries: completedSeries.length,
          maxWeightKg: maxWeight > 0 ? maxWeight : null,
          completedAt: now,
        );

        await database.insertWorkoutHistory(history);
      }

      // --- O RESET ACONTECE AQUI ---
      for (var series in seriesList) {
        // Usamos o copyWith para criar uma versão atualizada da série.
        // MANTEMOS weightKg e actualReps (para servirem de sugestão no próximo treino)
        // ALTERAMOS apenas isCompleted para false e completedAt para null
        final resetSeries = series.copyWith(
          isCompleted: false,
          completedAt: const Value(null),
          // weightKg e actualReps não são passados, então são mantidos automaticamente
        );

        // Atualiza no banco de dados
        await database.updateExerciseSeries(resetSeries);
      }
    }

    // Notifica a tela para recarregar se necessário
    notifyListeners();
  }
}

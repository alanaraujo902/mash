import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class ExerciseProvider extends ChangeNotifier {
  final AppDatabase database;
  Map<String, List<Exercise>> _exercisesBySessionMuscleGroup = {};
  Map<String, List<ExerciseSeries>> _exerciseSeriesList = {};

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
}

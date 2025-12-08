import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

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
}

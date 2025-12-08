import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class TrainingSessionProvider extends ChangeNotifier {
  final AppDatabase database;
  List<TrainingSession> _trainingSessions = [];
  Map<String, List<SessionMuscleGroup>> _sessionMuscleGroups = {};
  TrainingSession? _activeSession;

  TrainingSessionProvider(this.database);

  List<TrainingSession> get trainingSessions => _trainingSessions;
  TrainingSession? get activeSession => _activeSession;

  Future<void> loadTrainingSessions() async {
    _trainingSessions = await database.getAllTrainingSessions();
    notifyListeners();
  }

  Future<void> createTrainingSession(
    String name,
    List<String> muscleGroupIds,
  ) async {
    final session = TrainingSession(
      id: const Uuid().v4(),
      name: name,
      description: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await database.insertTrainingSession(session);

    // Adicionar grupos musculares à sessão
    for (int i = 0; i < muscleGroupIds.length; i++) {
      final smg = SessionMuscleGroup(
        id: const Uuid().v4(),
        sessionId: session.id,
        muscleGroupId: muscleGroupIds[i],
        order: i,
      );
      await database.insertSessionMuscleGroup(smg);
    }

    await loadTrainingSessions();
  }

  Future<void> loadSessionMuscleGroups(String sessionId) async {
    _sessionMuscleGroups[sessionId] =
        await database.getSessionMuscleGroups(sessionId);
    notifyListeners();
  }

  List<SessionMuscleGroup> getSessionMuscleGroups(String sessionId) {
    return _sessionMuscleGroups[sessionId] ?? [];
  }

  Future<void> setActiveSession(String sessionId) async {
    _activeSession = await database.getTrainingSessionById(sessionId);
    await loadSessionMuscleGroups(sessionId);
    notifyListeners();
  }

  Future<void> deleteTrainingSession(String id) async {
    await database.deleteTrainingSession(id);
    if (_activeSession?.id == id) {
      _activeSession = null;
    }
    await loadTrainingSessions();
  }

  Future<void> updateTrainingSession(
    String id,
    String name,
    String? description,
  ) async {
    final session = _trainingSessions.firstWhere((s) => s.id == id);
    final updated = session.copyWith(
      name: name,
      description: description ?? session.description,
      updatedAt: DateTime.now(),
    );
    await database.updateTrainingSession(updated);
    await loadTrainingSessions();
  }

  Future<void> addMuscleGroupToSession(
    String sessionId,
    String muscleGroupId,
  ) async {
    final currentGroups = getSessionMuscleGroups(sessionId);
    final smg = SessionMuscleGroup(
      id: const Uuid().v4(),
      sessionId: sessionId,
      muscleGroupId: muscleGroupId,
      order: currentGroups.length,
    );
    await database.insertSessionMuscleGroup(smg);
    await loadSessionMuscleGroups(sessionId);
  }

  Future<void> removeMuscleGroupFromSession(String smgId) async {
    await database.deleteSessionMuscleGroup(smgId);
    if (_activeSession != null) {
      await loadSessionMuscleGroups(_activeSession!.id);
    }
  }
}

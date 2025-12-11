import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

class TrainingSessionProvider extends ChangeNotifier {
  final AppDatabase database;
  List<TrainingSession> _trainingSessions = [];
  Map<String, List<SessionMuscleGroup>> _sessionMuscleGroups = {};
  TrainingSession? _activeSession;

  TrainingSessionProvider(this.database);

  List<TrainingSession> get trainingSessions => _trainingSessions;
  TrainingSession? get activeSession => _activeSession;
  AppDatabase get db => database;

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
      isDone: false, // Inicia como não concluído
    );

    await database.insertTrainingSession(session);

    // Adicionar grupos musculares à sessão
    for (int i = 0; i < muscleGroupIds.length; i++) {
      final smg = SessionMuscleGroup(
        id: const Uuid().v4(),
        sessionId: session.id,
        muscleGroupId: muscleGroupIds[i],
        order: i,
        isDone: false, // Inicia como não concluído
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
      description: Value(description ?? session.description),
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
      isDone: false, // Inicia como não concluído
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

  // NOVO: Alterna o status da SESSÃO DE TREINO (Ex: Treino A)
  Future<void> toggleSessionDone(String sessionId, bool value) async {
    // 1. Atualiza a sessão específica
    await (database.update(database.trainingSessions)
      ..where((tbl) => tbl.id.equals(sessionId)))
      .write(TrainingSessionsCompanion(isDone: Value(value)));

    // 2. Se marcou como FEITO (true), verifica se completou TODOS os treinos cadastrados
    if (value == true) {
      // Vamos recarregar para garantir que temos dados atualizados
      final updatedSessions = await database.getAllTrainingSessions();
      final allDone = updatedSessions.every((s) => s.isDone);

      if (allDone) {
        // 3. RESETAR CICLO: Define todas as sessões como false
        for (var session in updatedSessions) {
          await (database.update(database.trainingSessions)
            ..where((tbl) => tbl.id.equals(session.id)))
            .write(const TrainingSessionsCompanion(isDone: Value(false)));
        }
      }
    }

    await loadTrainingSessions(); // Atualiza a lista na tela
  }

  // Método antigo mantido para compatibilidade (pode ser removido se não for usado)
  Future<void> toggleGroupDone(String sessionMuscleGroupId, bool value) async {
    // 1. Atualiza o item específico
    final query = database.update(database.sessionMuscleGroups)
      ..where((tbl) => tbl.id.equals(sessionMuscleGroupId));
    
    await query.write(SessionMuscleGroupsCompanion(isDone: Value(value)));

    // 2. Se estiver marcando como FEITO (true), verificar se completou o ciclo
    if (value == true) {
      // Pega o item para saber qual é a sessão pai
      final item = await (database.select(database.sessionMuscleGroups)
        ..where((tbl) => tbl.id.equals(sessionMuscleGroupId))).getSingle();

      // Pega todos os itens dessa sessão
      final allItems = await database.getSessionMuscleGroups(item.sessionId);

      // Verifica se TODOS estão done = true
      final allDone = allItems.every((element) => element.isDone);

      if (allDone) {
        // 3. RESETAR CICLO: Define todos como false
        for (var group in allItems) {
          final resetQuery = database.update(database.sessionMuscleGroups)
            ..where((tbl) => tbl.id.equals(group.id));
          
          await resetQuery.write(const SessionMuscleGroupsCompanion(isDone: Value(false)));
        }
      }
    }

    // 4. Atualiza a lista na UI se houver sessão ativa
    if (_activeSession != null) {
      await loadSessionMuscleGroups(_activeSession!.id);
    }
    // Notifica ouvintes gerais (como a tela TrainScreen)
    notifyListeners();
  }
}

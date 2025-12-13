import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class RecoveryProvider extends ChangeNotifier {
  final AppDatabase database;

  // Mapa para status atual
  Map<String, MuscleRecovery> _recoveryStatus = {};
  
  // Mapa para histórico (MuscleGroupId -> Lista de Logs)
  Map<String, List<RecoveryHistoryLog>> _recoveryHistory = {};

  RecoveryProvider(this.database);

  MuscleRecovery? getStatus(String muscleGroupId) {
    return _recoveryStatus[muscleGroupId];
  }

  List<RecoveryHistoryLog> getHistory(String muscleGroupId) {
    return _recoveryHistory[muscleGroupId] ?? [];
  }

  Future<void> loadRecoveryData() async {
    final muscleGroups = await database.getAllMuscleGroups();

    for (var group in muscleGroups) {
      // 1. Carrega Status Atual
      final status = await database.getRecoveryStatus(group.id);
      if (status != null) {
        _recoveryStatus[group.id] = status;
      }

      // 2. Carrega Histórico
      final history = await database.getRecoveryHistory(group.id);
      _recoveryHistory[group.id] = history;
    }
    notifyListeners();
  }

  // Chamado automaticamente ao finalizar um treino
  Future<void> markAsFatigued(String muscleGroupId) async {
    await database.setMuscleFatigued(muscleGroupId);
    await loadRecoveryData();
  }

  // ATUALIZADO: Salva no histórico antes de marcar como recuperado
  Future<void> markAsRecovered(String muscleGroupId, DateTime recoveryDate) async {
    // 1. Busca o status atual para saber quando foi o treino (fatigueDate)
    final currentStatus = await database.getRecoveryStatus(muscleGroupId);

    if (currentStatus != null && currentStatus.lastWorkoutDate != null) {
      final fatigueDate = currentStatus.lastWorkoutDate!;
      
      // Calcula duração em horas
      final difference = recoveryDate.difference(fatigueDate);
      final hours = difference.inHours;

      // Só salva se a data de recuperação for posterior ao treino
      if (!difference.isNegative) {
        await database.insertRecoveryLog(
          RecoveryHistoryLog(
            id: const Uuid().v4(),
            muscleGroupId: muscleGroupId,
            fatigueDate: fatigueDate,
            recoveredDate: recoveryDate,
            durationInHours: hours,
          ),
        );
      }
    }

    // 2. Atualiza o status atual (Reseta para recuperado)
    await database.setMuscleRecovered(muscleGroupId, recoveryDate);
    
    // 3. Recarrega tudo
    await loadRecoveryData();
  }
}



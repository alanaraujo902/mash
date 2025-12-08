import 'package:flutter/material.dart';
import '../database/database.dart';

class RecoveryProvider extends ChangeNotifier {
  final AppDatabase database;

  // Mapa para acesso rápido: MuscleGroupId -> MuscleRecovery Data
  Map<String, MuscleRecovery> _recoveryStatus = {};

  RecoveryProvider(this.database);

  MuscleRecovery? getStatus(String muscleGroupId) {
    return _recoveryStatus[muscleGroupId];
  }

  Future<void> loadRecoveryData() async {
    // Carrega todos os grupos musculares para garantir que temos status para todos
    final muscleGroups = await database.getAllMuscleGroups();

    for (var group in muscleGroups) {
      final status = await database.getRecoveryStatus(group.id);
      if (status != null) {
        _recoveryStatus[group.id] = status;
      }
    }
    notifyListeners();
  }

  // Chamado automaticamente ao finalizar um treino
  Future<void> markAsFatigued(String muscleGroupId) async {
    await database.setMuscleFatigued(muscleGroupId);
    await loadRecoveryData();
  }

  // Chamado pelo usuário na tela de recuperação
  Future<void> markAsRecovered(String muscleGroupId, DateTime date) async {
    await database.setMuscleRecovered(muscleGroupId, date);
    await loadRecoveryData();
  }
}


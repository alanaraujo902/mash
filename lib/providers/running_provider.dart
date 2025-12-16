import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

// Estrutura de uma sessão de corrida
class RunningSessionStructure {
  final int level;
  final String description;
  final int warmupMinutes;
  final int runSeconds;
  final int walkSeconds;
  final int repetitions;
  final int cooldownMinutes;

  RunningSessionStructure({
    required this.level,
    required this.description,
    required this.warmupMinutes,
    required this.runSeconds,
    required this.walkSeconds,
    required this.repetitions,
    required this.cooldownMinutes,
  });

  int get totalTimeSeconds => 
      (warmupMinutes * 60) + 
      (repetitions * (runSeconds + walkSeconds)) + 
      (cooldownMinutes * 60);
}

class RunningProvider extends ChangeNotifier {
  final AppDatabase database;
  RunningProgress? _progress;
  
  // NOVO: Armazena uma customização temporária para o treino de hoje
  RunningSessionStructure? _customSessionOverride;

  RunningProvider(this.database) {
    loadProgress();
  }

  RunningProgress? get progress => _progress;

  Future<void> loadProgress() async {
    _progress = await database.getRunningProgress();
    notifyListeners();
  }

  // NOVO: Retorna a sessão efetiva (Customizada OU Automática)
  RunningSessionStructure getEffectiveSession() {
    // Se o usuário personalizou manualmente, retorna a dele
    if (_customSessionOverride != null) {
      return _customSessionOverride!;
    }
    // Senão, retorna a do algoritmo baseada no nível do banco
    return getSessionForLevel(_progress?.currentLevel ?? 1);
  }

  // NOVO: Verifica se há uma customização ativa
  bool get hasCustomSession => _customSessionOverride != null;

  // NOVO: Define uma sessão customizada (apenas para agora)
  void setCustomSession(RunningSessionStructure session) {
    _customSessionOverride = session;
    notifyListeners();
  }

  // NOVO: Limpa a customização (volta ao automático)
  void clearCustomSession() {
    _customSessionOverride = null;
    notifyListeners();
  }

  // NOVO: Altera o Nível permanentemente no banco (Override manual do progresso)
  Future<void> updateLevelManually(int newLevel) async {
    if (_progress != null) {
      await database.updateRunningProgress(newLevel, _progress!.weekDay, DateTime.now());
      await loadProgress();
      // Ao mudar de nível, limpamos customizações manuais para seguir o novo padrão
      _customSessionOverride = null; 
    }
  }

  // --- O ALGORITMO DE NÍVEIS (Mantido igual) ---
  RunningSessionStructure getSessionForLevel(int level) {
    const warmup = 5;
    const cooldown = 5;

    if (level <= 6) {
      return RunningSessionStructure(
        level: level,
        description: "Introdução: Trote Leve",
        warmupMinutes: warmup,
        runSeconds: 60, 
        walkSeconds: 120, 
        repetitions: 8, 
        cooldownMinutes: 0,
      );
    }
    else if (level <= 12) {
      final bool isHarder = level > 9; 
      return RunningSessionStructure(
        level: level,
        description: "Aumentando o Ritmo",
        warmupMinutes: warmup,
        runSeconds: isHarder ? 180 : 120,
        walkSeconds: isHarder ? 60 : 90,
        repetitions: isHarder ? 6 : 7,
        cooldownMinutes: cooldown,
      );
    }
    else if (level <= 18) {
      final int step = level - 12;
      return RunningSessionStructure(
        level: level,
        description: "Resistência Intermediária",
        warmupMinutes: warmup,
        runSeconds: 300 + (step * 30),
        walkSeconds: 120,
        repetitions: 3,
        cooldownMinutes: cooldown,
      );
    }
    else {
      final int step = level - 18;
      final int runTime = 12 + (step * 2);
      
      if (runTime >= 20) {
         return RunningSessionStructure(
          level: level,
          description: "Corrida Contínua",
          warmupMinutes: warmup,
          runSeconds: runTime * 60,
          walkSeconds: 0,
          repetitions: 1,
          cooldownMinutes: cooldown,
        );
      }

      return RunningSessionStructure(
        level: level,
        description: "Rumo aos 30min",
        warmupMinutes: warmup,
        runSeconds: runTime * 60,
        walkSeconds: 120,
        repetitions: 2,
        cooldownMinutes: cooldown,
      );
    }
  }

  // --- LÓGICA ADAPTATIVA ---
  Future<void> completeSession(int feedbackScore, int durationSeconds) async {
    if (_progress == null) return;

    final now = DateTime.now();
    
    // Salva o log
    await database.insertRunningLog(RunningLog(
      id: const Uuid().v4(),
      date: now,
      levelCompleted: _progress!.currentLevel,
      durationSeconds: durationSeconds,
      feedbackScore: feedbackScore,
      type: 'running', // Tipo obrigatório
    ));

    // Lógica de progressão (Só aplica se estivermos usando o modo automático ou se o usuário quiser)
    // Vamos assumir que o feedback sempre ajusta o nível base
    int nextLevel = _progress!.currentLevel;
    int nextDay = _progress!.weekDay + 1;

    if (feedbackScore == 1) {
      nextLevel += 2;
    } else if (feedbackScore == 2) {
      nextLevel += 1;
    } else if (feedbackScore >= 4) {
      if (nextLevel > 1) nextLevel -= 1;
    }

    if (nextDay > 3) nextDay = 1;

    await database.updateRunningProgress(nextLevel, nextDay, now);
    await loadProgress();
    
    // Limpa override para o próximo treino ser o sugerido
    _customSessionOverride = null; 
  }
}

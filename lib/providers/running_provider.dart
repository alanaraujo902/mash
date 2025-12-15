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

  RunningProvider(this.database) {
    loadProgress();
  }

  RunningProgress? get progress => _progress;

  Future<void> loadProgress() async {
    _progress = await database.getRunningProgress();
    notifyListeners();
  }

  // --- O ALGORITMO DE NÍVEIS ---
  // Define a progressão lógica baseada na sua descrição
  RunningSessionStructure getSessionForLevel(int level) {
    // 5 min aquecimento padrão
    const warmup = 5;
    const cooldown = 5; // 5 min desaquecimento padrão

    // Níveis 1-6 (Semanas 1-2): Foco em consistência
    // Ex: Nível 1 = 1m Corre / 2m Anda
    if (level <= 6) {
      return RunningSessionStructure(
        level: level,
        description: "Introdução: Trote Leve",
        warmupMinutes: warmup,
        runSeconds: 60, 
        walkSeconds: 120, 
        repetitions: 8, // ~29 min totais
        cooldownMinutes: 0, // Já tem muita caminhada
      );
    }
    // Níveis 7-12 (Semanas 3-4): Inverte relação
    // Ex: 2m Corre / 1m Anda
    else if (level <= 12) {
      // Pequena progressão dentro do bloco
      final bool isHarder = level > 9; 
      return RunningSessionStructure(
        level: level,
        description: "Aumentando o Ritmo",
        warmupMinutes: warmup,
        runSeconds: isHarder ? 180 : 120, // 2 ou 3 min
        walkSeconds: isHarder ? 60 : 90,  // 1 ou 1.5 min
        repetitions: isHarder ? 6 : 7,
        cooldownMinutes: cooldown,
      );
    }
    // Níveis 13-18 (Semanas 5-6): Blocos maiores
    // Ex: 5-8 min Corre / 2 min Anda
    else if (level <= 18) {
      final int step = level - 12; // 1 a 6
      return RunningSessionStructure(
        level: level,
        description: "Resistência Intermediária",
        warmupMinutes: warmup,
        runSeconds: 300 + (step * 30), // Começa em 5m, aumenta 30s por nível
        walkSeconds: 120,
        repetitions: 3,
        cooldownMinutes: cooldown,
      );
    }
    // Níveis 19+ (Semanas 7-8): Corrida Contínua
    else {
      final int step = level - 18;
      final int runTime = 12 + (step * 2); // 14, 16, 18... minutos ou mais blocos
      
      // Se for muito avançado, vira corrida direta
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

  // --- LÓGICA ADAPTATIVA (FEEDBACK) ---
  Future<void> completeSession(int feedbackScore, int durationSeconds) async {
    if (_progress == null) return;

    final now = DateTime.now();
    
    // Salvar Log
    await database.insertRunningLog(RunningLog(
      id: const Uuid().v4(),
      date: now,
      levelCompleted: _progress!.currentLevel,
      durationSeconds: durationSeconds,
      feedbackScore: feedbackScore,
    ));

    // Calcular Próximo Nível
    int nextLevel = _progress!.currentLevel;
    int nextDay = _progress!.weekDay + 1;

    // Lógica do Feedback (1=Muito Fácil ... 5=Impossível)
    if (feedbackScore == 1) {
      // Muito fácil: Pula um nível (Acelera progressão)
      nextLevel += 2;
    } else if (feedbackScore == 2) {
      // Fácil/Moderado: Segue normal
      nextLevel += 1;
    } else if (feedbackScore == 3) {
      // Difícil: Repete o nível para consolidar, mas avança o dia
      // (Mantém nextLevel igual)
    } else if (feedbackScore >= 4) {
      // Muito Difícil/Falha: Regride um nível se possível
      if (nextLevel > 1) nextLevel -= 1;
    }

    // Resetar dia da semana se passar de 3 (assumindo 3 treinos/semana)
    if (nextDay > 3) {
      nextDay = 1;
    }

    // Atualizar Progresso
    await database.updateRunningProgress(nextLevel, nextDay, now);
    await loadProgress();
  }
}


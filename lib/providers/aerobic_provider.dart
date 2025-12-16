import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

enum AerobicType { running, cycling }

class AerobicSessionStructure {
  final AerobicType type;
  final int level;
  final String description;
  final int warmupMinutes;
  final int mainIntervalSeconds; // Corrida ou Carga Moderada
  final int recoveryIntervalSeconds; // Caminhada ou Carga Leve
  final int repetitions;
  final int cooldownMinutes;

  AerobicSessionStructure({
    required this.type,
    required this.level,
    required this.description,
    required this.warmupMinutes,
    required this.mainIntervalSeconds,
    required this.recoveryIntervalSeconds,
    required this.repetitions,
    required this.cooldownMinutes,
  });

  int get totalTimeSeconds => 
      (warmupMinutes * 60) + 
      (repetitions * (mainIntervalSeconds + recoveryIntervalSeconds)) + 
      (cooldownMinutes * 60);

  // Compatibilidade com código antigo
  int get runSeconds => mainIntervalSeconds;
  int get walkSeconds => recoveryIntervalSeconds;
}

class AerobicProvider extends ChangeNotifier {
  final AppDatabase database;
  
  RunningProgress? _runProgress;
  RunningProgress? _bikeProgress;
  
  // Customização temporária
  AerobicSessionStructure? _customSessionOverride;

  AerobicProvider(this.database) {
    loadData();
  }

  RunningProgress? getProgress(AerobicType type) {
    return type == AerobicType.running ? _runProgress : _bikeProgress;
  }

  // Compatibilidade com código antigo
  RunningProgress? get progress => _runProgress;

  Future<void> loadData() async {
    _runProgress = await database.getProgressByType('running');
    _bikeProgress = await database.getProgressByType('cycling');
    notifyListeners();
  }

  // --- SESSÃO EFETIVA (Sugerida ou Custom) ---
  AerobicSessionStructure getEffectiveSession(AerobicType type) {
    if (_customSessionOverride != null && _customSessionOverride!.type == type) {
      return _customSessionOverride!;
    }
    final level = getProgress(type)?.currentLevel ?? 1;
    return getSessionForLevel(type, level);
  }

  // Compatibilidade com código antigo
  AerobicSessionStructure getEffectiveSessionLegacy() {
    return getEffectiveSession(AerobicType.running);
  }

  bool get hasCustomSession => _customSessionOverride != null;

  void setCustomSession(AerobicSessionStructure session) {
    _customSessionOverride = session;
    notifyListeners();
  }

  void clearCustomSession() {
    _customSessionOverride = null;
    notifyListeners();
  }

  Future<void> updateLevelManually(AerobicType type, int newLevel) async {
    final prog = getProgress(type);
    if (prog != null) {
      await database.updateProgressByType(type.name, newLevel, prog.weekDay, DateTime.now());
      await loadData();
      _customSessionOverride = null; 
    }
  }

  // Compatibilidade com código antigo
  Future<void> updateLevelManuallyLegacy(int newLevel) async {
    await updateLevelManually(AerobicType.running, newLevel);
  }

  // --- ALGORITMOS DE TREINO ---
  AerobicSessionStructure getSessionForLevel(AerobicType type, int level) {
    if (type == AerobicType.running) {
      return _getRunningLogic(level);
    } else {
      return _getCyclingLogic(level);
    }
  }

  // Compatibilidade com código antigo
  AerobicSessionStructure getSessionForLevelLegacy(int level) {
    return _getRunningLogic(level);
  }

  // 1. Lógica de Corrida (Couch to 5k) - Mantida
  AerobicSessionStructure _getRunningLogic(int level) {
    const warmup = 5; const cooldown = 5;
    if (level <= 6) {
      return AerobicSessionStructure(
        type: AerobicType.running, 
        level: level, 
        description: "Introdução: Trote", 
        warmupMinutes: warmup, 
        mainIntervalSeconds: 60, 
        recoveryIntervalSeconds: 120, 
        repetitions: 8, 
        cooldownMinutes: 0
      );
    } else if (level <= 12) {
      final bool isHarder = level > 9; 
      return AerobicSessionStructure(
        type: AerobicType.running, 
        level: level, 
        description: "Aumentando Ritmo", 
        warmupMinutes: warmup, 
        mainIntervalSeconds: isHarder ? 180 : 120, 
        recoveryIntervalSeconds: isHarder ? 60 : 90, 
        repetitions: isHarder ? 6 : 7, 
        cooldownMinutes: cooldown
      );
    } else if (level <= 18) {
      final int step = level - 12;
      return AerobicSessionStructure(
        type: AerobicType.running, 
        level: level, 
        description: "Resistência Interm.", 
        warmupMinutes: warmup, 
        mainIntervalSeconds: 300 + (step * 30), 
        recoveryIntervalSeconds: 120, 
        repetitions: 3, 
        cooldownMinutes: cooldown
      );
    } else {
      final int step = level - 18; 
      final int runTime = 12 + (step * 2);
      if (runTime >= 20) {
         return AerobicSessionStructure(
          type: AerobicType.running, 
          level: level, 
          description: "Corrida Contínua", 
          warmupMinutes: warmup, 
          mainIntervalSeconds: runTime * 60, 
          recoveryIntervalSeconds: 0, 
          repetitions: 1, 
          cooldownMinutes: cooldown
        );
      }
      return AerobicSessionStructure(
        type: AerobicType.running, 
        level: level, 
        description: "Rumo aos 30min", 
        warmupMinutes: warmup, 
        mainIntervalSeconds: runTime * 60, 
        recoveryIntervalSeconds: 120, 
        repetitions: 2, 
        cooldownMinutes: cooldown
      );
    }
  }

  // 2. Lógica de Bike (Base -> Intervalos de Limiar)
  AerobicSessionStructure _getCyclingLogic(int level) {
    // Fase 1: Construção de Base (Semanas 1-4) -> Níveis 1 a 12
    // Aumenta volume gradualmente. 15 min -> 45 min
    if (level <= 12) {
      // Começa com 15 min, aumenta ~2 min por nível
      int mainDurationMin = 15 + ((level - 1) * 2); 
      
      return AerobicSessionStructure(
        type: AerobicType.cycling,
        level: level,
        description: "Base Aeróbica (RPM Constante)",
        warmupMinutes: 5,
        // Hack: 1 repetição gigante representando o tempo contínuo
        mainIntervalSeconds: mainDurationMin * 60, 
        recoveryIntervalSeconds: 0,
        repetitions: 1,
        cooldownMinutes: 5, // Washout
      );
    } 
    // Fase 2: Intervalos de Limiar (Semanas 5-8) -> Níveis 13+
    else {
      // Protocolo: 3 min moderado (Zona 3) / 1 min forte (Zona 4)
      // Aumenta o número de repetições
      int baseReps = 4;
      int extraReps = (level - 13) ~/ 2; // Aumenta 1 rep a cada 2 níveis
      
      return AerobicSessionStructure(
        type: AerobicType.cycling,
        level: level,
        description: "Intervalos de Limiar (3x1)",
        warmupMinutes: 5,
        mainIntervalSeconds: 60, // 1 min Forte/Zona 4 (Tiro)
        recoveryIntervalSeconds: 180, // 3 min Moderado/Zona 3 (Base)
        repetitions: baseReps + extraReps,
        cooldownMinutes: 5,
      );
    }
  }

  Future<void> completeSession(AerobicType type, int feedbackScore, int durationSeconds) async {
    final prog = getProgress(type);
    if (prog == null) return;

    final now = DateTime.now();
    
    await database.insertRunningLog(RunningLog(
      id: const Uuid().v4(),
      date: now,
      levelCompleted: prog.currentLevel,
      durationSeconds: durationSeconds,
      feedbackScore: feedbackScore,
      type: type.name, // Salva 'running' ou 'cycling'
    ));

    int nextLevel = prog.currentLevel;
    int nextDay = prog.weekDay + 1;

    if (feedbackScore == 1) nextLevel += 2;
    else if (feedbackScore == 2) nextLevel += 1;
    else if (feedbackScore >= 4 && nextLevel > 1) nextLevel -= 1;

    if (nextDay > 3) nextDay = 1;

    await database.updateProgressByType(type.name, nextLevel, nextDay, now);
    await loadData();
    _customSessionOverride = null; 
  }

  // Compatibilidade com código antigo
  Future<void> completeSessionLegacy(int feedbackScore, int durationSeconds) async {
    await completeSession(AerobicType.running, feedbackScore, durationSeconds);
  }
}


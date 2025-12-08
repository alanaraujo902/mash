import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutTimerProvider extends ChangeNotifier {
  // Timer Geral (Sessão completa)
  Timer? _globalTimer;
  Duration _totalDuration = Duration.zero;
  bool _isRunning = false;

  // NOVO: Mapa para armazenar o tempo acumulado de cada grupo (Chave: ID do SessionMuscleGroup)
  final Map<String, Duration> _groupDurations = {};

  Duration get totalDuration => _totalDuration;
  bool get isRunning => _isRunning;

  // --- Lógica Geral ---

  // Inicia o timer geral apenas se não estiver rodando
  void startGlobalTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _globalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _totalDuration += const Duration(seconds: 1);
        notifyListeners(); // Atualiza quem estiver ouvindo o tempo total
      });
    }
  }

  // Para o timer (ex: quando finalizar todo o treino do dia)
  void stopAndResetGlobalTimer() {
    _globalTimer?.cancel();
    _totalDuration = Duration.zero;
    _isRunning = false;

    // NOVO: Limpa os tempos parciais dos grupos ao finalizar o treino do dia
    _groupDurations.clear();

    notifyListeners();
  }

  String get formattedTotalTime => _formatDuration(_totalDuration);

  // --- Lógica por Grupo Muscular (NOVO) ---

  // Recupera o tempo salvo de um grupo (ou zero se nunca começou)
  Duration getGroupDuration(String id) {
    return _groupDurations[id] ?? Duration.zero;
  }

  // Salva o tempo atual do grupo (sem notificar ouvintes para não reconstruir a tela inteira a cada segundo sem necessidade)
  void updateGroupDuration(String id, Duration duration) {
    _groupDurations[id] = duration;
    // Não chamamos notifyListeners() aqui por performance,
    // pois a tela ativa já tem seu próprio setState local.
  }

  // Helper de formatação
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? "$hours:$minutes:$seconds"
        : "$minutes:$seconds";
  }
}


import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutTimerProvider extends ChangeNotifier {
  // Timer Geral (Sessão completa)
  Timer? _globalTimer;
  Duration _totalDuration = Duration.zero;
  bool _isRunning = false;

  Duration get totalDuration => _totalDuration;
  bool get isRunning => _isRunning;

  // Inicia o timer geral apenas se não estiver rodando
  void startGlobalTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _globalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _totalDuration += const Duration(seconds: 1);
        notifyListeners();
      });
    }
  }

  // Para o timer (ex: quando finalizar todo o treino do dia)
  void stopAndResetGlobalTimer() {
    _globalTimer?.cancel();
    _totalDuration = Duration.zero;
    _isRunning = false;
    notifyListeners();
  }

  // Formatação de texto (ex: 01:30:45)
  String get formattedTotalTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_totalDuration.inHours);
    final minutes = twoDigits(_totalDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_totalDuration.inSeconds.remainder(60));
    return _totalDuration.inHours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }
}


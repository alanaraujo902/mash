import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/running_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class ActiveRunningScreen extends StatefulWidget {
  final RunningSessionStructure session;

  const ActiveRunningScreen({Key? key, required this.session}) : super(key: key);

  @override
  State<ActiveRunningScreen> createState() => _ActiveRunningScreenState();
}

class _ActiveRunningScreenState extends State<ActiveRunningScreen> {
  // Estados do Timer
  late int _totalSeconds;
  Timer? _timer;
  bool _isPaused = false;
  
  // Controle de Intervalos
  String _phaseName = "Aquecimento";
  Color _phaseColor = Colors.orange;
  int _phaseSecondsRemaining = 0;
  
  // Controle Lógico
  int _currentRep = 0;
  bool _isRunningPhase = false; // true = correr, false = caminhar
  bool _isWarmup = true;
  bool _isCooldown = false;

  @override
  void initState() {
    super.initState();
    _phaseSecondsRemaining = widget.session.warmupMinutes * 60;
    _totalSeconds = 0;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _totalSeconds++;
          if (_phaseSecondsRemaining > 0) {
            _phaseSecondsRemaining--;
          } else {
            _nextPhase();
          }
        });
      }
    });
  }

  void _nextPhase() {
    // Lógica da Máquina de Estados
    if (_isWarmup) {
      // Fim do Aquecimento -> Começa 1ª Repetição (Correr)
      _isWarmup = false;
      _currentRep = 1;
      _startRunPhase();
    } else if (_isCooldown) {
      // Fim do treino
      _finishRun();
    } else {
      // Estamos nos intervalos
      if (_isRunningPhase) {
        // Acabou de correr -> Caminhar (ou Cooldown se acabou reps)
        if (widget.session.walkSeconds > 0) {
           _startWalkPhase();
        } else {
           // Se não tem caminhada (corrida continua), verifica reps
           _checkRepsOrFinish();
        }
      } else {
        // Acabou de caminhar -> Verificar se tem mais repetições
        _checkRepsOrFinish();
      }
    }
  }

  void _checkRepsOrFinish() {
    if (_currentRep < widget.session.repetitions) {
      _currentRep++;
      _startRunPhase();
    } else {
      _startCooldown();
    }
  }

  void _startRunPhase() {
    _isRunningPhase = true;
    _phaseName = "CORRER";
    _phaseColor = AppColors.neonGreen; // Verde para ação
    _phaseSecondsRemaining = widget.session.runSeconds;
    // Vibrar ou som aqui seria ideal
  }

  void _startWalkPhase() {
    _isRunningPhase = false;
    _phaseName = "CAMINHAR";
    _phaseColor = Colors.blue; // Azul para descanso
    _phaseSecondsRemaining = widget.session.walkSeconds;
  }

  void _startCooldown() {
    _isCooldown = true;
    _phaseName = "DESAQUECIMENTO";
    _phaseColor = Colors.orangeAccent;
    _phaseSecondsRemaining = widget.session.cooldownMinutes * 60;
  }

  void _finishRun() {
    _timer?.cancel();
    _showFeedbackDialog();
  }

  Future<void> _showFeedbackDialog() async {
    int score = 3; // Moderado padrão

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final isNeon = context.watch<ThemeProvider>().isNeon;
          return AlertDialog(
            backgroundColor: isNeon ? AppColors.neonCard : null,
            title: Text(
              'Treino Concluído!',
              style: TextStyle(color: isNeon ? Colors.white : null),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Como você sentiu a dificuldade? Isso ajustará seu próximo treino.',
                  style: TextStyle(color: isNeon ? Colors.grey[300] : null),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: score.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _getFeedbackLabel(score),
                  activeColor: _getFeedbackColor(score),
                  onChanged: (val) {
                    setDialogState(() => score = val.toInt());
                  },
                ),
                Text(
                  _getFeedbackLabel(score),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getFeedbackColor(score),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.read<RunningProvider>().completeSession(score, _totalSeconds);
                  if (mounted) {
                    Navigator.pop(context); // Dialog
                    Navigator.pop(context); // Screen
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getFeedbackLabel(int score) {
    switch (score) {
      case 1: return "Muito Fácil (Aumentar)";
      case 2: return "Fácil";
      case 3: return "Moderado (Ideal)";
      case 4: return "Difícil";
      case 5: return "Exaustivo/Falha (Diminuir)";
      default: return "";
    }
  }

  Color _getFeedbackColor(int score) {
    if (score <= 2) return Colors.green;
    if (score == 3) return Colors.blue;
    return Colors.red;
  }

  String _formatTime(int totalSeconds) {
    int m = totalSeconds ~/ 60;
    int s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;
    
    // Calcula progresso do círculo baseado no tempo restante da fase
    double phaseProgress = 1.0;
    int phaseTotalSeconds = 0;
    if (_isWarmup) {
      phaseTotalSeconds = widget.session.warmupMinutes * 60;
    } else if (_isCooldown) {
      phaseTotalSeconds = widget.session.cooldownMinutes * 60;
    } else if (_isRunningPhase) {
      phaseTotalSeconds = widget.session.runSeconds;
    } else {
      phaseTotalSeconds = widget.session.walkSeconds;
    }
    
    if (phaseTotalSeconds > 0) {
      phaseProgress = _phaseSecondsRemaining / phaseTotalSeconds;
    }
    
    return Scaffold(
      backgroundColor: isNeon ? AppColors.neonBackground : _phaseColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Modo Corrida'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FASE ATUAL
            Text(
              _phaseName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: isNeon ? _phaseColor : Colors.black87,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            if (!_isWarmup && !_isCooldown)
              Text(
                'Repetição $_currentRep / ${widget.session.repetitions}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            
            const SizedBox(height: 40),

            // TIMER GIGANTE (Contagem Regressiva da Fase)
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: 1, // Full circle background
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 20,
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: phaseProgress,
                    color: _phaseColor,
                    strokeWidth: 20,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(_phaseSecondsRemaining),
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: isNeon ? Colors.white : Colors.black87,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const Text("Restante", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            // TEMPO TOTAL
            Text(
              'Tempo Total: ${_formatTime(_totalSeconds)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 40),

            // CONTROLES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  backgroundColor: _isPaused ? Colors.green : Colors.amber,
                  child: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                  onPressed: () {
                    setState(() => _isPaused = !_isPaused);
                  },
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.stop),
                  onPressed: _finishRun, // Finaliza manual
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


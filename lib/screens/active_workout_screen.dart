import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';
import '../providers/exercise_provider.dart';
import '../providers/recovery_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';
import 'dart:async';
import 'dart:ui';

// Enum para controlar o estado visual do timer
enum TimerViewMode { hidden, expanded, minimized }

class ActiveWorkoutScreen extends StatefulWidget {
  final SessionMuscleGroup sessionMuscleGroup;
  final String groupName;
  final String trainingSessionId;

  const ActiveWorkoutScreen({
    Key? key,
    required this.sessionMuscleGroup,
    required this.groupName,
    required this.trainingSessionId,
  }) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  bool _isLoading = true;
  List<Exercise> _exercises = [];

  // Timer Local (Grupo)
  Timer? _groupTimer;
  Duration _groupDuration = Duration.zero;
  
  // ignore: unused_field
  late DateTime _groupStartTime; 

  // --- Timer de Descanso ---
  Timer? _restTimer;
  int _restSecondsRemaining = 0;
  
  // Estado visual do timer (Começa escondido)
  TimerViewMode _timerViewMode = TimerViewMode.hidden;

  @override
  void initState() {
    super.initState();
    _loadExercises();

    _groupStartTime = DateTime.now();

    Future.microtask(() {
      context.read<WorkoutTimerProvider>().startGlobalTimer();
    });

    final savedDuration = context
        .read<WorkoutTimerProvider>()
        .getGroupDuration(widget.sessionMuscleGroup.id);

    _groupDuration = savedDuration;

    _startGroupTimer();
  }

  void _startGroupTimer() {
    _groupTimer?.cancel();

    _groupTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _groupDuration += const Duration(seconds: 1);
        });

        context.read<WorkoutTimerProvider>().updateGroupDuration(
              widget.sessionMuscleGroup.id,
              _groupDuration,
            );
      }
    });
  }

  // --- Lógica do Timer de Descanso ---
  void _startRestTimer(int seconds) {
    _restTimer?.cancel();
    setState(() {
      _restSecondsRemaining = seconds;
      // AO INICIAR: Aparece no modo EXPANDIDO (Antiga aparência)
      _timerViewMode = TimerViewMode.expanded;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_restSecondsRemaining > 0) {
            _restSecondsRemaining--;
          } else {
            _stopRestTimer();
          }
        });
      }
    });
  }

  void _stopRestTimer() {
    _restTimer?.cancel();
    setState(() {
      _restSecondsRemaining = 0;
      _timerViewMode = TimerViewMode.hidden;
    });
  }

  void _addRestTime(int seconds) {
    setState(() {
      _restSecondsRemaining += seconds;
    });
  }

  // Alterna entre minimizado e expandido
  void _toggleTimerMode() {
    setState(() {
      if (_timerViewMode == TimerViewMode.expanded) {
        _timerViewMode = TimerViewMode.minimized;
      } else if (_timerViewMode == TimerViewMode.minimized) {
        _timerViewMode = TimerViewMode.expanded;
      }
    });
  }

  @override
  void dispose() {
    _groupTimer?.cancel();
    _restTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    return "$hours$minutes:$seconds";
  }

  Future<void> _loadExercises() async {
    await context
        .read<ExerciseProvider>()
        .loadExercises(widget.sessionMuscleGroup.id);

    if (mounted) {
      setState(() {
        _exercises = context
            .read<ExerciseProvider>()
            .getExercises(widget.sessionMuscleGroup.id);
        _isLoading = false;
      });
    }
  }

  void _checkOverallCompletion() async {
    final provider = context.read<ExerciseProvider>();
    final isAllDone = await provider.checkAllExercisesCompleted(widget.sessionMuscleGroup.id);

    if (isAllDone && mounted) {
      _stopRestTimer(); 
      // Chama o dialog indicando que está 100% completo
      _showCompletionDialog(isComplete: true);
    }
  }

  // Lógica do botão manual "Finalizar"
  void _manualFinish() async {
    final provider = context.read<ExerciseProvider>();
    final isAllDone = await provider.checkAllExercisesCompleted(widget.sessionMuscleGroup.id);
    
    // Chama o dialog, passando o status real
    _showCompletionDialog(isComplete: isAllDone);
  }

  // Dialog unificado (serve tanto para completo quanto para parcial)
  void _showCompletionDialog({required bool isComplete}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isComplete ? '🎉 Treino Concluído!' : '⚠️ Finalizar Parcialmente?'),
        content: Text(
          'Tempo do grupo: ${_formatDuration(_groupDuration)}\n\n' +
          (isComplete 
            ? 'Parabéns! Você completou todas as séries.' 
            : 'Você ainda tem séries pendentes. O que foi feito será salvo e o treino será encerrado.') +
          '\n\nDeseja salvar no histórico?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancelar
            child: const Text('Voltar / Revisar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isComplete ? Colors.green : Colors.orange,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              // 1. Salvar no histórico
              await context.read<ExerciseProvider>().finishSessionMuscleGroup(
                widget.sessionMuscleGroup.id,
                widget.trainingSessionId,
              );

              // 2. Marcar grupo muscular como FATIGADO
              if (mounted) {
                await context.read<RecoveryProvider>().markAsFatigued(
                  widget.sessionMuscleGroup.muscleGroupId,
                );
              }

              if (mounted) {
                Navigator.pop(context); // Fecha dialog
                Navigator.pop(context); // Sai da tela

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isComplete ? 'Treino finalizado com sucesso!' : 'Treino parcial salvo!'),
                    backgroundColor: isComplete ? Colors.green : Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Confirmar Fim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalTime = context.watch<WorkoutTimerProvider>().formattedTotalTime;
    final isNeon = context.watch<ThemeProvider>().isNeon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Treinando: ${widget.groupName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause_circle_filled),
            tooltip: 'Pausar / Sair sem finalizar',
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      // --- NOVO BOTÃO FLUTUANTE PARA FINALIZAR A QUALQUER MOMENTO ---
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0), // Acima da lista se necessário
        child: FloatingActionButton.extended(
          onPressed: _manualFinish,
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Finalizar'),
          backgroundColor: isNeon ? AppColors.neonGreen : Colors.green,
          foregroundColor: isNeon ? Colors.black : Colors.white,
        ),
      ),
      body: SafeArea(
        // Usamos Stack para permitir o overlay do Timer Expandido
        child: Stack(
          children: [
            Column(
              children: [
                // --- BARRA DE TIMERS DO TOPO ---
                _buildTopBar(context, globalTime, isNeon),

                // --- LISTA DE EXERCÍCIOS ---
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _exercises.isEmpty
                          ? const Center(child: Text('Nenhum exercício neste grupo.'))
                          : ListView.builder(
                              // Padding extra no final para o FAB não cobrir o último item
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                              itemCount: _exercises.length,
                              itemBuilder: (context, index) {
                                return _ExerciseItem(
                                  exercise: _exercises[index],
                                  onCheckCompletion: _checkOverallCompletion,
                                  onStartRestTimer: (seconds) {
                                    _startRestTimer(seconds);
                                    _checkOverallCompletion();
                                  },
                                  isNeon: isNeon,
                                );
                              },
                            ),
                ),
              ],
            ),

            // --- OVERLAY: TIMER EXPANDIDO (Aparência Antiga) ---
            if (_timerViewMode == TimerViewMode.expanded)
              _buildExpandedTimerOverlay(isNeon),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE UI ---

  // Barra Superior (Contém o timer minimizado se necessário)
  Widget _buildTopBar(BuildContext context, String globalTime, bool isNeon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: isNeon
          ? BoxDecoration(
              color: AppColors.neonCard,
              border: Border(
                bottom: BorderSide(
                  color: _timerViewMode == TimerViewMode.minimized ? Colors.blueAccent : AppColors.neonPurple,
                  width: 2,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: (_timerViewMode == TimerViewMode.minimized ? Colors.blueAccent : AppColors.neonPurple).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            )
          : BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Timer do Grupo
          _buildTimerColumn(
            context,
            'TEMPO GRUPO',
            _formatDuration(_groupDuration),
            isNeon ? AppColors.neonGreen : null,
          ),

          // MEIO: Timer Minimizado OU Divisor
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: _timerViewMode == TimerViewMode.minimized
                  ? _buildMinimizedTimerWidget(isNeon)
                  : Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Container(width: 1, color: Colors.grey.withOpacity(0.5)),
                    ),
            ),
          ),

          // Timer Total
          _buildTimerColumn(
            context,
            'TEMPO TOTAL',
            globalTime,
            isNeon ? AppColors.neonPurple : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTimerColumn(BuildContext context, String label, String time, Color? color) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).colorScheme.onPrimaryContainer,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // --- TIMER MINIMIZADO (Topo) ---
  Widget _buildMinimizedTimerWidget(bool isNeon) {
    return GestureDetector(
      // GESTO: Arrastar para BAIXO expande
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          setState(() => _timerViewMode = TimerViewMode.expanded);
        }
      },
      // GESTO: Clicar também expande
      onTap: () => setState(() => _timerViewMode = TimerViewMode.expanded),
      child: Container(
        key: const ValueKey('minimizedTimer'),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.blueAccent),
            const Text(
              'DESCANSO',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            Text(
              '$_restSecondsRemaining s',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TIMER EXPANDIDO (Overlay / Aparência Antiga) ---
  Widget _buildExpandedTimerOverlay(bool isNeon) {
    return Container(
      color: Colors.black.withOpacity(0.7), // Fundo escuro transparente (Modal)
      child: Center(
        child: GestureDetector(
          // GESTO: Arrastar para CIMA minimiza
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) { // Negativo = Cima
              setState(() => _timerViewMode = TimerViewMode.minimized);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isNeon ? AppColors.neonCard : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isNeon ? AppColors.neonPurple : Colors.blueAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isNeon ? AppColors.neonPurple : Colors.blue).withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicador de arraste
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.timer, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text(
                      'Descanso',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '$_restSecondsRemaining',
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Text('segundos restantes'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => _addRestTime(10),
                      child: const Text('+10s', style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                      onPressed: _stopRestTimer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Pular / Continuar'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Arraste para cima para minimizar',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget da Série Individual (Mantido igual)
class _ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onCheckCompletion;
  final Function(int) onStartRestTimer;
  final bool isNeon;

  const _ExerciseItem({
    Key? key,
    required this.exercise,
    required this.onCheckCompletion,
    required this.onStartRestTimer,
    required this.isNeon,
  }) : super(key: key);

  @override
  State<_ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<_ExerciseItem> {
  bool _isExpanded = true; 
  List<ExerciseSeries> _series = [];
  List<WorkoutHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = context.read<ExerciseProvider>();
    await Future.wait([
      provider.loadExerciseSeries(widget.exercise.id),
      provider.loadExerciseHistory(widget.exercise.id),
    ]);
    
    if (mounted) {
      setState(() {
        _series = provider.getExerciseSeries(widget.exercise.id);
        _history = provider.getExerciseHistory(widget.exercise.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeonCard(
      isNeon: widget.isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.exercise.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.isNeon ? AppColors.neonGreen : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: widget.isNeon ? AppColors.neonPurple : null,
              ),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ),
          if (_isExpanded) ...[
            Column(
              children: _series.map((serie) => _SeriesRow(
                serie: serie,
                isUnilateral: widget.exercise.isUnilateral, 
                onSeriesCompleted: () {
                  widget.onStartRestTimer(widget.exercise.intervalSeconds);
                },
                onSave: () => _loadData(),
              )).toList(),
            ),
            
            const Divider(height: 24, thickness: 1),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey[800], fontSize: 14),
                        children: [
                          const TextSpan(
                            text: '🎯 Meta: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${widget.exercise.plannedSeries} séries de ${widget.exercise.plannedReps} repetições (${widget.exercise.intervalSeconds}s descanso)',
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  const Text(
                    'Histórico (Últimas cargas):',
                    style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  if (_history.isEmpty)
                    const Text(
                      'Sem histórico registrado.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _history.take(4).map((record) {
                          final dateStr = '${record.completedAt.day}/${record.completedAt.month}';
                          final weightStr = record.maxWeightKg != null 
                              ? '${record.maxWeightKg!.toStringAsFixed(1).replaceAll('.0', '')}kg' 
                              : '-';

                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey.shade50,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  weightStr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  dateStr,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SeriesRow extends StatefulWidget {
  final ExerciseSeries serie;
  final bool isUnilateral;
  final VoidCallback onSeriesCompleted;
  final VoidCallback onSave;

  const _SeriesRow({
    Key? key,
    required this.serie,
    required this.isUnilateral,
    required this.onSeriesCompleted,
    required this.onSave,
  }) : super(key: key);

  @override
  State<_SeriesRow> createState() => _SeriesRowState();
}

class _SeriesRowState extends State<_SeriesRow> {
  late TextEditingController _weightController;
  late TextEditingController _repsController;
  bool _isCompleted = false;
  bool _leftSideDone = false;  
  bool _rightSideDone = false; 

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
      text: widget.serie.weightKg?.toString().replaceAll('.0', '') ?? '',
    );

    _repsController = TextEditingController(
      text: widget.serie.actualReps?.toString() ?? '',
    );

    _isCompleted = widget.serie.isCompleted;
    
    if (_isCompleted) {
      _leftSideDone = true;
      _rightSideDone = true;
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  Future<void> _toggleSide({bool isLeft = true, bool isStandard = false}) async {
    if (_weightController.text.isEmpty || _repsController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha carga e repetições')));
       return;
    }

    final weight = double.tryParse(_weightController.text);
    final reps = int.tryParse(_repsController.text);
    if (weight == null || reps == null) return;

    setState(() {
      if (isStandard) {
        _isCompleted = !_isCompleted;
      } else {
        if (isLeft) _leftSideDone = !_leftSideDone;
        else _rightSideDone = !_rightSideDone;
        
        _isCompleted = _leftSideDone && _rightSideDone;
      }
    });

    final provider = context.read<ExerciseProvider>();

    if (_isCompleted) {
      await provider.updateExerciseSeries(
        widget.serie.id,
        reps,
        weight,
      );
      
      widget.onSeriesCompleted();
      
    } else {
      if (widget.serie.isCompleted) {
        final updatedSerie = widget.serie.copyWith(
          isCompleted: false,
          actualReps: drift.Value(reps), 
          weightKg: drift.Value(weight), 
          completedAt: const drift.Value(null), 
        );
        
        await provider.database.updateExerciseSeries(updatedSerie);
        await provider.loadExerciseSeries(widget.serie.exerciseId);
      }
    }
    
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isCompleted ? Colors.green.withOpacity(0.1) : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              '#${widget.serie.seriesNumber}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Kg',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              enabled: !_isCompleted,
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Reps',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              enabled: !_isCompleted,
            ),
          ),
          const SizedBox(width: 8),

          if (widget.isUnilateral) ...[
            InkWell(
              onTap: () => _toggleSide(isLeft: true),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    const Text("E", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Icon(
                      _leftSideDone ? Icons.check_circle : Icons.circle_outlined,
                      color: _leftSideDone ? Colors.green : Colors.grey,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: () => _toggleSide(isLeft: false),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    const Text("D", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Icon(
                      _rightSideDone ? Icons.check_circle : Icons.circle_outlined,
                      color: _rightSideDone ? Colors.green : Colors.grey,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            IconButton(
              icon: Icon(
                _isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                color: _isCompleted ? Colors.green : Colors.grey,
                size: 32,
              ),
              onPressed: () => _toggleSide(isStandard: true),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../providers/exercise_provider.dart';
import '../providers/recovery_provider.dart';
import '../providers/workout_timer_provider.dart';
import 'home_screen.dart';
import 'dart:async';

class ActiveWorkoutScreen extends StatefulWidget {
  final SessionMuscleGroup sessionMuscleGroup;
  final String groupName;
  final String trainingSessionId; // NOVO CAMPO

  const ActiveWorkoutScreen({
    Key? key,
    required this.sessionMuscleGroup,
    required this.groupName,
    required this.trainingSessionId, // NOVO CAMPO NO CONSTRUTOR
  }) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  bool _isLoading = true;
  List<Exercise> _exercises = [];

  // Timer Local (Específico deste Grupo Muscular)
  Timer? _groupTimer;
  Duration _groupDuration = Duration.zero;
  late DateTime _groupStartTime; // Para salvar no banco com precisão

  @override
  void initState() {
    super.initState();
    _loadExercises();

    // Configura tempo de início real para o banco de dados
    _groupStartTime = DateTime.now();

    // 1. Inicia o Timer Geral (Via Provider)
    // O microtask garante que o build já ocorreu antes de chamar o provider
    Future.microtask(() {
      context.read<WorkoutTimerProvider>().startGlobalTimer();
    });

    // 2. Inicia o Timer Local (Desta tela)
    _startGroupTimer();
  }

  void _startGroupTimer() {
    _groupTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _groupDuration += const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _groupTimer?.cancel(); // Cancela apenas o timer local ao sair da tela
    super.dispose();
  }

  // Helper para formatar o tempo local
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

    setState(() {
      _exercises = context
          .read<ExerciseProvider>()
          .getExercises(widget.sessionMuscleGroup.id);
      _isLoading = false;
    });
  }

  void _checkOverallCompletion() async {
    final provider = context.read<ExerciseProvider>();
    final isAllDone = await provider.checkAllExercisesCompleted(widget.sessionMuscleGroup.id);

    if (isAllDone && mounted) {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Treino Concluído!'),
        content: Text(
          'Tempo do grupo: ${_formatDuration(_groupDuration)}\n'
          'Parabéns! Você completou todas as séries.\nDeseja finalizar o treino e salvar no histórico?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancelar e ficar na tela
            child: const Text('Revisar'),
          ),
          ElevatedButton(
            onPressed: () async {
              // 1. Salvar no histórico (código existente)
              await context.read<ExerciseProvider>().finishSessionMuscleGroup(
                widget.sessionMuscleGroup.id,
                widget.trainingSessionId,
              );

              // 2. Marcar grupo muscular como FATIGADO (NOVO)
              if (mounted) {
                // Precisamos do ID do grupo muscular real, não o da sessão
                await context.read<RecoveryProvider>().markAsFatigued(
                  widget.sessionMuscleGroup.muscleGroupId,
                );
              }

              // NOTA IMPORTANTE:
              // Se o usuário clicar em "Finalizar", entendemos que ele acabou ESTE grupo.
              // O Timer Geral continua rodando pois ele pode ir para outro grupo.
              // Se quiser parar o Timer Geral aqui, chame:
              // context.read<WorkoutTimerProvider>().stopAndResetGlobalTimer();
              // Mas como o pedido é timer "geral quando trocar de grupo", não paramos aqui.

              if (mounted) {
                Navigator.pop(context); // Fecha dialog
                Navigator.pop(context); // Sai da tela de treino (Volta para lista)

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Grupo finalizado!')),
                );
              }
            },
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Consumir o timer global
    final globalTime = context.watch<WorkoutTimerProvider>().formattedTotalTime;

    return Scaffold(
      appBar: AppBar(
        title: Text('Treinando: ${widget.groupName}'),
        actions: [
          // Botão de Pause
          IconButton(
            icon: const Icon(Icons.pause_circle_filled),
            tooltip: 'Pausar Treino',
            onPressed: () {
              // Simplesmente volta para a tela anterior, salvando o estado atual (já salvo no DB)
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          // --- BARRA DE TIMERS ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Timer do Grupo (Local)
                Column(
                  children: [
                    const Text(
                      'TEMPO GRUPO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDuration(_groupDuration),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
                // Divisor Vertical
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
                // Timer Geral (Global)
                Column(
                  children: [
                    const Text(
                      'TEMPO TOTAL',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      globalTime,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- CONTEÚDO DA LISTA DE EXERCÍCIOS ---
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _exercises.isEmpty
                    ? const Center(child: Text('Nenhum exercício neste grupo.'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) {
                          return _ExerciseItem(
                            exercise: _exercises[index],
                            onCheckCompletion:
                                _checkOverallCompletion, // Passando o callback
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET DO CRONÔMETRO (NOVO) ---
class RestTimerDialog extends StatefulWidget {
  final int initialSeconds;

  const RestTimerDialog({Key? key, required this.initialSeconds}) : super(key: key);

  @override
  State<RestTimerDialog> createState() => _RestTimerDialogState();
}

class _RestTimerDialogState extends State<RestTimerDialog> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        Navigator.of(context).pop(); // Fecha o diálogo automaticamente
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.timer, color: Colors.blueAccent),
          SizedBox(width: 10),
          Text('Descanso'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$_remainingSeconds',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const Text('segundos restantes'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Adiciona +10 segundos
            setState(() {
              _remainingSeconds += 10;
            });
          },
          child: const Text('+10s'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Pular / Continuar'),
        ),
      ],
    );
  }
}

class _ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onCheckCompletion; // NOVO CALLBACK

  const _ExerciseItem({
    Key? key,
    required this.exercise,
    required this.onCheckCompletion, // NOVO
  }) : super(key: key);

  @override
  State<_ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<_ExerciseItem> {
  bool _isExpanded = true; // Começa expandido para facilitar
  List<ExerciseSeries> _series = [];
  List<WorkoutHistory> _history = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = context.read<ExerciseProvider>();
    // Carrega séries e histórico simultaneamente
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

  // Função para abrir o timer
  void _showRestTimer() {
    showDialog(
      context: context,
      barrierDismissible: false, // O usuário deve clicar no botão para fechar
      builder: (context) => RestTimerDialog(
        initialSeconds: widget.exercise.intervalSeconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.exercise.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ),
          if (_isExpanded) ...[
            // Lista de Séries (Inputs)
            Column(
              children: _series.map((serie) => _SeriesRow(
                serie: serie,
                // Passamos a função do timer e verificação para a linha
                onSeriesCompleted: () {
                  // 1. Mostra o timer
                  _showRestTimer();
                  // 2. Verifica se o treino todo acabou
                  widget.onCheckCompletion();
                },
                onSave: () => _loadData(),
              )).toList(),
            ),
            
            const Divider(height: 24, thickness: 1),
            
            // Área de Informações (Meta e Histórico)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Meta Inicial
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
                  
                  // 2. Histórico das últimas 4 sessões
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
                          // Formatação simples da data (Dia/Mês)
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
  final VoidCallback onSeriesCompleted; // Callback para iniciar o timer
  final VoidCallback onSave;

  const _SeriesRow({
    Key? key,
    required this.serie,
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // AQUI ESTÁ A LÓGICA DO PESO ANTERIOR:
    // O banco já guarda o 'weightKg' da última atualização.
    // Inicializamos o controlador com esse valor se ele existir.
    _weightController = TextEditingController(
      text: widget.serie.weightKg?.toString().replaceAll('.0', '') ?? '',
    );

    // Repetições também podem ser pré-carregadas se desejar
    _repsController = TextEditingController(
      text: widget.serie.actualReps?.toString() ?? '',
    );

    _isCompleted = widget.serie.isCompleted;
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _saveSeries() async {
    if (_weightController.text.isEmpty || _repsController.text.isEmpty) return;

    final weight = double.tryParse(_weightController.text);
    final reps = int.tryParse(_repsController.text);

    if (weight != null && reps != null) {
      await context.read<ExerciseProvider>().updateExerciseSeries(
            widget.serie.id,
            reps,
            weight,
          );

      // Armazena o estado antigo
      final wasCompleted = _isCompleted;

      // Recarregar séries para atualizar o estado
      final provider = context.read<ExerciseProvider>();
      await provider.loadExerciseSeries(widget.serie.exerciseId);
      
      // Notificar o componente pai para recarregar
      widget.onSave();
      
      // Buscar a série atualizada
      final updatedSeries = provider.getExerciseSeries(widget.serie.exerciseId);
      final updatedSerie = updatedSeries.firstWhere(
        (s) => s.id == widget.serie.id,
        orElse: () => widget.serie,
      );

      if (mounted) {
        setState(() {
          _isCompleted = updatedSerie.isCompleted;
        });

        // Só inicia o timer se estiver marcando como completo (não quando desmarca)
        if (!wasCompleted && updatedSerie.isCompleted) {
          widget.onSeriesCompleted();
        }

        // Feedback visual
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Série salva!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isCompleted ? Colors.green.withOpacity(0.1) : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Número da série
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              '#${widget.serie.seriesNumber}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),

          // Peso
          Expanded(
            child: TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Kg',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              enabled: !_isCompleted, // Desabilita edição se concluído
            ),
          ),
          const SizedBox(width: 8),

          // Repetições
          Expanded(
            child: TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Reps',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              enabled: !_isCompleted, // Desabilita edição se concluído
            ),
          ),
          const SizedBox(width: 16),

          // Checkbox / Botão Salvar
          IconButton(
            icon: Icon(
              _isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: _isCompleted ? Colors.green : Colors.grey,
            ),
            onPressed: _saveSeries,
          ),
        ],
      ),
    );
  }
}


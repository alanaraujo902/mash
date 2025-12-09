import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift; // <--- ALTERADO: Importação com alias para evitar erros
import '../database/database.dart';
import '../providers/exercise_provider.dart';
import '../providers/recovery_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';
import 'dart:async';
import 'dart:ui'; // Necessário para FontFeature

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
  
  // ignore: unused_field
  late DateTime _groupStartTime;

  // --- NOVO: Variáveis para o Timer de Descanso Inline ---
  Timer? _restTimer;
  int _restSecondsRemaining = 0;
  bool get _isResting => _restSecondsRemaining > 0;

  @override
  void initState() {
    super.initState();
    _loadExercises();

    // Configura tempo de início real para o banco de dados
    _groupStartTime = DateTime.now();

    // 1. Inicia/Garante que o Timer Geral esteja rodando
    Future.microtask(() {
      context.read<WorkoutTimerProvider>().startGlobalTimer();
    });

    // 2. RECUPERA O TEMPO SALVO (Correção do problema)
    // Buscamos no provider se já existe um tempo para este grupo
    final savedDuration = context
        .read<WorkoutTimerProvider>()
        .getGroupDuration(widget.sessionMuscleGroup.id);

    _groupDuration = savedDuration;

    // 3. Inicia o Timer Local
    _startGroupTimer();
  }

  void _startGroupTimer() {
    // Cancela anterior se houver (segurança)
    _groupTimer?.cancel();

    _groupTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          // Incrementa localmente para a UI atualizar
          _groupDuration += const Duration(seconds: 1);
        });

        // SALVA NO PROVIDER A CADA SEGUNDO
        // Isso garante que se o usuário sair, o valor está salvo
        context.read<WorkoutTimerProvider>().updateGroupDuration(
              widget.sessionMuscleGroup.id,
              _groupDuration,
            );
      }
    });
  }

  // --- NOVO: Lógica do Timer de Descanso ---
  void _startRestTimer(int seconds) {
    _restTimer?.cancel();
    setState(() {
      _restSecondsRemaining = seconds;
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
    });
  }

  void _addRestTime(int seconds) {
    setState(() {
      _restSecondsRemaining += seconds;
    });
  }

  @override
  void dispose() {
    // Ao sair da tela, paramos O TIMER LOCAL (o do provider não roda sozinho, é só memória)
    // Isso cumpre o requisito: "parado quando eu der play em outro grupo"
    _groupTimer?.cancel();
    _restTimer?.cancel(); // Cancelar timer de descanso ao sair
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
      // Se acabou tudo, para o descanso também
      _stopRestTimer();
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
    final isNeon = context.watch<ThemeProvider>().isNeon;

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
      body: SafeArea(
        child: Column(
          children: [
          // --- BARRA DE TIMERS ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            // Animação de altura suave se o timer de descanso mudar o tamanho do container (opcional)
            decoration: isNeon
                ? BoxDecoration(
                    color: AppColors.neonCard,
                    border: Border(
                      bottom: BorderSide(
                        color: _isResting ? Colors.blueAccent : AppColors.neonPurple, // Muda cor se descansando
                        width: 2,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isResting ? Colors.blueAccent : AppColors.neonPurple).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                : BoxDecoration(
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
                // 1. Timer do Grupo (Esquerda)
                _buildTimerColumn(
                  context, 
                  'TEMPO GRUPO', 
                  _formatDuration(_groupDuration), 
                  isNeon ? AppColors.neonGreen : null,
                  isNeon
                ),

                // 2. MEIO: Ou Divisor Ou Timer de Descanso
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: _isResting
                        ? _buildRestTimerWidget(isNeon) // <--- MOSTRA O TIMER
                        : Container( // <--- MOSTRA O DIVISOR
                            key: const ValueKey('divider'),
                            height: 30,
                            alignment: Alignment.center,
                            child: Container(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                  ),
                ),

                // 3. Timer Total (Direita)
                _buildTimerColumn(
                  context, 
                  'TEMPO TOTAL', 
                  globalTime, 
                  isNeon ? AppColors.neonPurple : null,
                  isNeon
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
                            onCheckCompletion: _checkOverallCompletion,
                            // Passamos a função para iniciar o timer
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
      ),
    );
  }

  // Widget auxiliar para as colunas de tempo (Grupo e Total)
  Widget _buildTimerColumn(BuildContext context, String label, String time, Color? color, bool isNeon) {
    return SizedBox(
      width: 80, // Largura fixa para evitar pulos no layout
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
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

  // Widget do Timer de Descanso (A caixinha do meio)
  Widget _buildRestTimerWidget(bool isNeon) {
    return Container(
      key: const ValueKey('restTimer'),
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
          const Text(
            'DESCANSO',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botão Pular
              InkWell(
                onTap: _stopRestTimer,
                child: const Icon(Icons.close, size: 16, color: Colors.grey),
              ),
              const SizedBox(width: 8),

              // O Contador
              Text(
                '$_restSecondsRemaining',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const Text('s', style: TextStyle(fontSize: 12, color: Colors.blueAccent)),

              const SizedBox(width: 8),

              // Botão +10s
              InkWell(
                onTap: () => _addRestTime(10),
                child: const Icon(Icons.add_circle_outline, size: 16, color: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Removido: RestTimerDialog (Não é mais usado)

class _ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onCheckCompletion;
  final Function(int) onStartRestTimer; // NOVO CALLBACK COM INTEIRO
  final bool isNeon;

  const _ExerciseItem({
    Key? key,
    required this.exercise,
    required this.onCheckCompletion,
    required this.onStartRestTimer, // REQUERIDO
    required this.isNeon,
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

  // Função interna removida, agora chamamos o callback do pai

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
            // Lista de Séries (Inputs)
            Column(
              children: _series.map((serie) => _SeriesRow(
                serie: serie,
                isUnilateral: widget.exercise.isUnilateral, 
                onSeriesCompleted: () {
                  // Ao completar a série, iniciamos o timer passando o tempo configurado
                  widget.onStartRestTimer(widget.exercise.intervalSeconds);
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
  final bool isUnilateral; // <--- NOVO
  final VoidCallback onSeriesCompleted; // Callback para iniciar o timer
  final VoidCallback onSave;

  const _SeriesRow({
    Key? key,
    required this.serie,
    required this.isUnilateral, // <--- RECEBER
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
  bool _leftSideDone = false;  // Visual apenas
  bool _rightSideDone = false; // Visual apenas
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
    
    // Se já estava completo no banco, marcamos os dois lados visualmente
    if (_isCompleted) {
      _leftSideDone = true;
      _rightSideDone = true;
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // Nova função lógica separada para organizar
  Future<void> _toggleSide({bool isLeft = true, bool isStandard = false}) async {
    // Validação básica
    if (_weightController.text.isEmpty || _repsController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha carga e repetições')));
       return;
    }

    final weight = double.tryParse(_weightController.text);
    final reps = int.tryParse(_repsController.text);
    if (weight == null || reps == null) return;

    final wasCompleted = _isCompleted;

    setState(() {
      if (isStandard) {
        _isCompleted = !_isCompleted;
      } else {
        // Unilateral
        if (isLeft) _leftSideDone = !_leftSideDone;
        else _rightSideDone = !_rightSideDone;
        
        _isCompleted = _leftSideDone && _rightSideDone;
      }
    });

    final provider = context.read<ExerciseProvider>();

    if (_isCompleted) {
      // Salva como COMPLETO (Database define isCompleted = true)
      await provider.updateExerciseSeries(
        widget.serie.id,
        reps,
        weight,
      );
      
      // Callback para tocar timer/verificar fim
      widget.onSeriesCompleted();
      
    } else {
      // Se desmarcou e estava completo, precisamos reverter no banco
      if (widget.serie.isCompleted) {
        // Precisamos de um método no provider que force isCompleted = false
        // Mas mantendo os dados (updateExerciseSeries atual seta true).
        // Solução rápida: Atualiza o objeto manualmente via Drift

        // Usa drift.Value para evitar erro de namespace
        final updatedSerie = widget.serie.copyWith(
          isCompleted: false,
          actualReps: drift.Value(reps), // <--- CORREÇÃO AQUI
          weightKg: drift.Value(weight), // <--- CORREÇÃO AQUI
          completedAt: const drift.Value(null), // <--- CORREÇÃO AQUI
        );
        
        await provider.database.updateExerciseSeries(updatedSerie);
        // Atualiza a lista local do provider
        await provider.loadExerciseSeries(widget.serie.exerciseId);
      }
    }
    
    // Atualiza a UI pai
    widget.onSave();
  }

  Future<void> _saveSeries() async {
    // Método mantido para compatibilidade, mas agora usa _toggleSide
    await _toggleSide(isStandard: !widget.isUnilateral);
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
          const SizedBox(width: 8),

          // CHECKBOXES
          if (widget.isUnilateral) ...[
            // LADO ESQUERDO
            InkWell(
              onTap: () => _toggleSide(isLeft: true),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("E", style: TextStyle(fontSize: 10, color: Colors.grey)),
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
            // LADO DIREITO
            InkWell(
              onTap: () => _toggleSide(isLeft: false),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text("D", style: TextStyle(fontSize: 10, color: Colors.grey)),
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
            // CHECKBOX PADRÃO ÚNICO
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


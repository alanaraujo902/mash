import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../providers/exercise_provider.dart';
import 'dart:async';

class ActiveWorkoutScreen extends StatefulWidget {
  final SessionMuscleGroup sessionMuscleGroup;
  final String groupName;

  const ActiveWorkoutScreen({
    Key? key,
    required this.sessionMuscleGroup,
    required this.groupName,
  }) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  bool _isLoading = true;
  List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
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

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _exercises.isEmpty
              ? const Center(child: Text('Nenhum exercício neste grupo.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    return _ExerciseItem(exercise: _exercises[index]);
                  },
                ),
    );
  }
}

class _ExerciseItem extends StatefulWidget {
  final Exercise exercise;

  const _ExerciseItem({Key? key, required this.exercise}) : super(key: key);

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
                            text: '${widget.exercise.plannedSeries} séries de ${widget.exercise.plannedReps} repetições',
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
  final VoidCallback onSave;

  const _SeriesRow({
    Key? key,
    required this.serie,
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


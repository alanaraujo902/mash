import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../providers/exercise_provider.dart';
import '../database/database.dart';

class WorkoutScreen extends StatefulWidget {
  final String exerciseId;
  final String exerciseName;
  final String sessionMuscleGroupId;

  const WorkoutScreen({
    Key? key,
    required this.exerciseId,
    required this.exerciseName,
    required this.sessionMuscleGroupId,
  }) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late Timer _timer;
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();
  int _completedSeries = 0;
  int _currentSeriesIndex = 0;
  List<ExerciseSeries>? _exerciseSeries;
  Exercise? _exercise;

  @override
  void initState() {
    super.initState();
    _loadExerciseData();
  }

  Future<void> _loadExerciseData() async {
    final exerciseProvider = context.read<ExerciseProvider>();
    await exerciseProvider.loadExerciseSeries(widget.exerciseId);
    
    final series = exerciseProvider.getExerciseSeries(widget.exerciseId);
    
    setState(() {
      _exerciseSeries = series;
    });
  }

  void _startInterval(int seconds) {
    int remaining = seconds;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          if (_timer.isActive) _timer.cancel();
          
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              remaining--;
            });
            if (remaining <= 0) {
              timer.cancel();
              Navigator.pop(context);
            }
          });

          return AlertDialog(
            title: const Text('Intervalo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$remaining',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                const Text('segundos'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _timer.cancel();
                  Navigator.pop(context);
                },
                child: const Text('Pular'),
              ),
            ],
          );
        },
      ),
    ).then((_) {
      if (_timer.isActive) _timer.cancel();
    });
  }

  void _completeSeries() {
    if (_weightController.text.isEmpty || _repsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha peso e repetições')),
      );
      return;
    }

    final weight = double.parse(_weightController.text);
    final reps = int.parse(_repsController.text);

    if (_exerciseSeries != null && _currentSeriesIndex < _exerciseSeries!.length) {
      final series = _exerciseSeries![_currentSeriesIndex];
      
      context.read<ExerciseProvider>().updateExerciseSeries(
        series.id,
        reps,
        weight,
      );

      setState(() {
        _completedSeries++;
        _currentSeriesIndex++;
        _weightController.clear();
        _repsController.clear();
      });

      if (_currentSeriesIndex < _exerciseSeries!.length) {
        _startInterval(_exercise?.intervalSeconds ?? 60);
      } else {
        _showCompletionDialog();
      }
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exercício Concluído!'),
        content: Text('Você completou $_completedSeries séries'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
      ),
      body: SafeArea(
        child: _exerciseSeries == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Série ${_currentSeriesIndex + 1} de ${_exerciseSeries!.length}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: _currentSeriesIndex / _exerciseSeries!.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Peso (kg)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Digite o peso',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Repetições',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _repsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Digite as repetições',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _completeSeries,
                      child: const Text('Série Concluída'),
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}

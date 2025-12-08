import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_provider.dart';
import '../database/database.dart'; // Import necessário para o tipo Exercise

class AddExerciseScreen extends StatefulWidget {
  final String sessionMuscleGroupId;
  final Exercise? exerciseToEdit; // NOVO: Parâmetro opcional para edição

  const AddExerciseScreen({
    Key? key,
    required this.sessionMuscleGroupId,
    this.exerciseToEdit, // Recebe null se for criar, ou o objeto se for editar
  }) : super(key: key);

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _nameController = TextEditingController();
  int _plannedSeries = 3;
  int _plannedReps = 10;
  int _intervalSeconds = 60;

  @override
  void initState() {
    super.initState();
    // SE ESTIVERMOS EDITANDO, PREENCHEMOS OS CAMPOS
    if (widget.exerciseToEdit != null) {
      final e = widget.exerciseToEdit!;
      _nameController.text = e.name;
      _plannedSeries = e.plannedSeries;
      _plannedReps = e.plannedReps;
      _intervalSeconds = e.intervalSeconds;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.exerciseToEdit != null;

    return Scaffold(
      appBar: AppBar(
        // Muda o título dependendo da ação
        title: Text(isEditing ? 'Editar Exercício' : 'Adicionar Exercício'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome do Exercício',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Ex: Supino, Rosca Direta...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Séries Planejadas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildCounterRow(
              value: _plannedSeries,
              onChanged: (val) => setState(() => _plannedSeries = val),
              min: 1,
            ),
            const SizedBox(height: 24),
            Text(
              'Repetições Planejadas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildCounterRow(
              value: _plannedReps,
              onChanged: (val) => setState(() => _plannedReps = val),
              min: 1,
            ),
            const SizedBox(height: 24),
            Text(
              'Intervalo entre Séries (segundos)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildCounterRow(
              value: _intervalSeconds,
              onChanged: (val) => setState(() => _intervalSeconds = val),
              min: 10,
              step: 10,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nameController.text.isEmpty
                    ? null
                    : () async {
                        if (isEditing) {
                          // LÓGICA DE ATUALIZAÇÃO
                          await context.read<ExerciseProvider>().updateExercise(
                                widget.exerciseToEdit!.id,
                                _nameController.text,
                                _plannedSeries,
                                _plannedReps,
                                _intervalSeconds,
                              );
                        } else {
                          // LÓGICA DE CRIAÇÃO
                          await context.read<ExerciseProvider>().addExercise(
                                widget.sessionMuscleGroupId,
                                _nameController.text,
                                _plannedSeries,
                                _plannedReps,
                                _intervalSeconds,
                              );
                        }

                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: Text(isEditing ? 'Salvar Alterações' : 'Adicionar Exercício'),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  // Widget auxiliar para evitar repetição de código nos contadores
  Widget _buildCounterRow({
    required int value,
    required Function(int) onChanged,
    int min = 1,
    int step = 1,
  }) {
    return Row(
      children: [
        IconButton(
          onPressed: value > min
              ? () {
                  onChanged(value - step);
                }
              : null,
          icon: const Icon(Icons.remove),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            onChanged(value + step);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

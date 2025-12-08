import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_provider.dart';

class AddExerciseScreen extends StatefulWidget {
  final String sessionMuscleGroupId;

  const AddExerciseScreen({
    Key? key,
    required this.sessionMuscleGroupId,
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
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Exercício'),
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
            Row(
              children: [
                IconButton(
                  onPressed: _plannedSeries > 1
                      ? () {
                          setState(() => _plannedSeries--);
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _plannedSeries.toString(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _plannedSeries++);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Repetições Planejadas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _plannedReps > 1
                      ? () {
                          setState(() => _plannedReps--);
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _plannedReps.toString(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _plannedReps++);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Intervalo entre Séries (segundos)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _intervalSeconds > 10
                      ? () {
                          setState(() => _intervalSeconds -= 10);
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _intervalSeconds.toString(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _intervalSeconds += 10);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nameController.text.isEmpty
                    ? null
                    : () async {
                        await context.read<ExerciseProvider>().addExercise(
                              widget.sessionMuscleGroupId,
                              _nameController.text,
                              _plannedSeries,
                              _plannedReps,
                              _intervalSeconds,
                            );
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: const Text('Adicionar Exercício'),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

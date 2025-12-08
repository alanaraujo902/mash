import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_provider.dart';
import 'add_exercise_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final String sessionMuscleGroupId;
  final String muscleGroupName;

  const ExerciseListScreen({
    Key? key,
    required this.sessionMuscleGroupId,
    required this.muscleGroupName,
  }) : super(key: key);

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<ExerciseProvider>()
          .loadExercises(widget.sessionMuscleGroupId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.muscleGroupName),
      ),
      body: Consumer<ExerciseProvider>(
        builder: (context, exerciseProvider, _) {
          final exercises =
              exerciseProvider.getExercises(widget.sessionMuscleGroupId);

          if (exercises.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sports_gymnastics,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum exercício adicionado',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adicione um exercício para começar',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          // ALTERAÇÃO AQUI: Usando ReorderableListView
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            onReorder: (oldIndex, newIndex) {
              context.read<ExerciseProvider>().reorderExercises(
                    widget.sessionMuscleGroupId,
                    oldIndex,
                    newIndex,
                  );
            },
            // Adicionando um proxyDecorator para melhorar o visual enquanto arrasta
            proxyDecorator: (child, index, animation) {
              return Material(
                elevation: 4,
                color: Colors.transparent,
                child: child,
              );
            },
            itemBuilder: (context, index) {
              final exercise = exercises[index];

              // IMPORTANTE: Cada item precisa de uma Key única para o ReorderableListView funcionar
              return Card(
                key: ValueKey(exercise.id),
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  // Ícone de arrastar à esquerda para indicar a funcionalidade
                  leading: const Icon(Icons.drag_handle, color: Colors.grey),
                  title: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        // Séries e Repetições
                        const Icon(Icons.repeat, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${exercise.plannedSeries} x ${exercise.plannedReps}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        const SizedBox(width: 16),

                        // Separador
                        Container(
                          width: 1,
                          height: 14,
                          color: Colors.grey[300],
                        ),

                        const SizedBox(width: 16),

                        // Intervalo de Descanso
                        const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${exercise.intervalSeconds}s',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Excluir exercício'),
                          content: Text('Deseja excluir "${exercise.name}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await context
                                    .read<ExerciseProvider>()
                                    .deleteExercise(exercise.id);
                                if (ctx.mounted) Navigator.pop(ctx);
                              },
                              child: const Text(
                                'Excluir',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExerciseScreen(
                sessionMuscleGroupId: widget.sessionMuscleGroupId,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

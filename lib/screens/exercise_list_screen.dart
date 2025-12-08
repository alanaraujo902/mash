import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exercise_provider.dart';
import 'add_exercise_screen.dart';
import 'workout_screen.dart';

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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // --- ALTERAÇÃO AQUI ---
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
                  // ---------------------
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutScreen(
                          exerciseId: exercise.id,
                          exerciseName: exercise.name,
                          sessionMuscleGroupId: widget.sessionMuscleGroupId,
                        ),
                      ),
                    );
                  },
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

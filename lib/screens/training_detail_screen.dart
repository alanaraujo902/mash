import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import 'exercise_list_screen.dart';

class TrainingDetailScreen extends StatefulWidget {
  final String sessionId;

  const TrainingDetailScreen({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TrainingSessionProvider>().setActiveSession(widget.sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Sessão'),
      ),
      body: Consumer2<TrainingSessionProvider, MuscleGroupProvider>(
        builder: (context, trainingProvider, muscleProvider, _) {
          final sessionMuscleGroups =
              trainingProvider.getSessionMuscleGroups(widget.sessionId);

          if (sessionMuscleGroups.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sessionMuscleGroups.length,
            itemBuilder: (context, index) {
              final smg = sessionMuscleGroups[index];
              final muscleGroup = muscleProvider.muscleGroups
                  .firstWhere((g) => g.id == smg.muscleGroupId);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor:
                        muscleProvider.getColorFromHex(muscleGroup.color),
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    muscleGroup.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseListScreen(
                          sessionMuscleGroupId: smg.id,
                          muscleGroupName: muscleGroup.name,
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
    );
  }
}

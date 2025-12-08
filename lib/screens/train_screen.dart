import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../database/database.dart';
import 'active_workout_screen.dart';

class TrainScreen extends StatelessWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinar'),
        elevation: 0,
      ),
      body: Consumer2<TrainingSessionProvider, MuscleGroupProvider>(
        builder: (context, trainingProvider, muscleProvider, _) {
          final sessions = trainingProvider.trainingSessions;

          if (sessions.isEmpty) {
            return Center(
              child: Text(
                'Configure seus treinos na aba "Configuração"',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return _TrainingSessionCard(
                session: session,
                trainingProvider: trainingProvider,
                muscleProvider: muscleProvider,
              );
            },
          );
        },
      ),
    );
  }
}

class _TrainingSessionCard extends StatefulWidget {
  final TrainingSession session;
  final TrainingSessionProvider trainingProvider;
  final MuscleGroupProvider muscleProvider;

  const _TrainingSessionCard({
    required this.session,
    required this.trainingProvider,
    required this.muscleProvider,
  });

  @override
  State<_TrainingSessionCard> createState() => _TrainingSessionCardState();
}

class _TrainingSessionCardState extends State<_TrainingSessionCard> {
  bool _isExpanded = false;
  List<SessionMuscleGroup> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    // Busca os grupos desta sessão específica no banco
    final groups = await widget.trainingProvider.db
        .getSessionMuscleGroups(widget.session.id);
    if (mounted) {
      setState(() {
        _groups = groups;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.session.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) _loadGroups();
              });
            },
          ),
          if (_isExpanded)
            if (_groups.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Nenhum grupo muscular configurado.'),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _groups.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final smg = _groups[index];
                  // Encontra o nome do grupo muscular
                  final muscleGroup = widget.muscleProvider.muscleGroups
                      .firstWhere(
                    (g) => g.id == smg.muscleGroupId,
                    orElse: () => MuscleGroup(
                      id: '',
                      name: 'Desconhecido',
                      color: '#000000',
                      order: 0,
                      createdAt: DateTime.now(),
                    ),
                  );

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          widget.muscleProvider.getColorFromHex(muscleGroup.color),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(muscleGroup.name),
                    trailing: ElevatedButton.icon(
                      onPressed: () {
                        // Navega para a tela de execução do treino
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActiveWorkoutScreen(
                              sessionMuscleGroup: smg,
                              groupName: muscleGroup.name,
                              trainingSessionId: widget.session.id,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}


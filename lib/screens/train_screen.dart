import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../providers/theme_provider.dart';
import '../database/database.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';
import 'active_workout_screen.dart';

class TrainScreen extends StatelessWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTimerRunning = context.watch<WorkoutTimerProvider>().isRunning;
    final totalTime = context.watch<WorkoutTimerProvider>().formattedTotalTime;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinar'),
        elevation: 0,
        actions: [
          if (isTimerRunning)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: () {
                    // Botão para parar o timer global manualmente
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Finalizar Treino do Dia?'),
                        content: Text(
                          'Tempo total: $totalTime\nIsso irá zerar o cronômetro geral.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<WorkoutTimerProvider>()
                                  .stopAndResetGlobalTimer();
                              Navigator.pop(ctx);
                            },
                            child: const Text('Finalizar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.stop_circle_outlined,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          totalTime,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
      body: SafeArea(
        child: Consumer3<TrainingSessionProvider, MuscleGroupProvider, ThemeProvider>(
        builder: (context, trainingProvider, muscleProvider, themeProvider, _) {
          final sessions = trainingProvider.trainingSessions;
          final isNeon = themeProvider.isNeon;

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
                isNeon: isNeon,
              );
            },
          );
        },
        ),
      ),
    );
  }
}

class _TrainingSessionCard extends StatefulWidget {
  final TrainingSession session;
  final TrainingSessionProvider trainingProvider;
  final MuscleGroupProvider muscleProvider;
  final bool isNeon;

  const _TrainingSessionCard({
    required this.session,
    required this.trainingProvider,
    required this.muscleProvider,
    required this.isNeon,
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
    return NeonCard(
      isNeon: widget.isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.session.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.isNeon ? AppColors.neonGreen : null,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: widget.isNeon ? AppColors.neonPurple : null,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) _loadGroups();
              });
            },
          ),
          if (_isExpanded)
            if (_groups.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Nenhum grupo muscular configurado.',
                  style: TextStyle(
                    color: widget.isNeon ? AppColors.neonGreen : null,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _groups.length,
                // --- ALTERAÇÃO: Linha sólida de 2px com cor neon roxa ---
                separatorBuilder: (_, __) => Divider(
                  height: 2, // Altura total do widget divisor
                  thickness: 2, // Espessura da linha desenhada
                  color: widget.isNeon
                      ? AppColors.neonPurple // Cor sólida do neon
                      : null,
                ),
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
                      backgroundColor: widget.muscleProvider
                          .getColorFromHex(muscleGroup.color),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      muscleGroup.name,
                      style: TextStyle(
                        color: widget.isNeon ? AppColors.neonGreen : null,
                      ),
                    ),
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
                        backgroundColor: widget.isNeon
                            ? AppColors.neonPurple
                            : Theme.of(context).primaryColor,
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


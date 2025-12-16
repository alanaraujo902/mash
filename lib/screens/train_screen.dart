import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/running_provider.dart';
import '../providers/daily_context_provider.dart';
import '../database/database.dart';
import '../widgets/neon_card.dart';
import '../widgets/daily_context_dialog.dart';
import '../utils/app_colors.dart';
import 'active_workout_screen.dart';
import 'active_running_screen.dart';

class TrainScreen extends StatelessWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTimerRunning = context.watch<WorkoutTimerProvider>().isRunning;
    final totalTime = context.watch<WorkoutTimerProvider>().formattedTotalTime;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Treinar'),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Musculação'),
              Tab(text: 'Corrida'),
            ],
          ),
          actions: [
            if (isTimerRunning)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Finalizar Treino do Dia?'),
                          content: Text('Tempo total: $totalTime\nIsso irá zerar o cronômetro geral.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                            TextButton(
                              onPressed: () {
                                context.read<WorkoutTimerProvider>().stopAndResetGlobalTimer();
                                Navigator.pop(ctx);
                              },
                              child: const Text('Finalizar'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stop_circle_outlined, color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(totalTime, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        body: const TabBarView(
          children: [
            _BodyBuildingTab(),
            _RunningTab(),
          ],
        ),
      ),
    );
  }
}

// --- ABA MUSCULAÇÃO ---
class _BodyBuildingTab extends StatelessWidget {
  const _BodyBuildingTab();

  @override
  Widget build(BuildContext context) {
    return Consumer3<TrainingSessionProvider, MuscleGroupProvider, ThemeProvider>(
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
    );
  }
}

// --- ABA CORRIDA ---
class _RunningTab extends StatelessWidget {
  const _RunningTab();

  @override
  Widget build(BuildContext context) {
    return Consumer2<RunningProvider, ThemeProvider>(
      builder: (context, runningProvider, themeProvider, _) {
        final isNeon = themeProvider.isNeon;
        final runProgress = runningProvider.progress;
        
        // Pega a sessão sugerida (ou o override se configurado na config)
        final suggestedRun = runningProvider.getEffectiveSession();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            NeonCard(
              isNeon: isNeon,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_run, color: isNeon ? AppColors.neonGreen : Colors.orange, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Próximo Treino",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isNeon ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    "Nível ${suggestedRun.level} • ${suggestedRun.description}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? AppColors.neonPurple : Colors.blue, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.timer, "Aquecimento", "${suggestedRun.warmupMinutes} min", isNeon),
                  _buildInfoRow(Icons.repeat, "Série (${suggestedRun.repetitions}x)", "${suggestedRun.runSeconds}s Trote / ${suggestedRun.walkSeconds}s Caminhada", isNeon),
                  _buildInfoRow(Icons.timer_off, "Desaquecimento", "${suggestedRun.cooldownMinutes} min", isNeon),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tempo Total Estimado:"),
                      Text(
                        "~${(suggestedRun.totalTimeSeconds/60).toStringAsFixed(0)} min",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_circle_filled, size: 28),
                      label: const Text("INICIAR CORRIDA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isNeon ? AppColors.neonGreen : Colors.orange,
                        foregroundColor: isNeon ? Colors.black : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Verificação de Contexto Diário (Igual à musculação)
                        _checkContextAndRun(context, suggestedRun);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkContextAndRun(BuildContext context, dynamic session) async {
    final dailyProvider = context.read<DailyContextProvider>();
    final hasContext = await dailyProvider.hasContextForToday();
    bool shouldProceed = true;

    if (!hasContext) {
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const DailyContextDialog(),
      );
      shouldProceed = result ?? false;
    }

    if (shouldProceed && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActiveRunningScreen(session: session),
        ),
      );
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isNeon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text("$label: ", style: TextStyle(color: isNeon ? Colors.grey[400] : Colors.grey[700])),
          Expanded(child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? Colors.white : Colors.black))),
        ],
      ),
    );
  }
}

// --- WIDGET DO CARD DE MUSCULAÇÃO (Mantido igual) ---
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
    final groups = await widget.trainingProvider.db.getSessionMuscleGroups(widget.session.id);
    if (mounted) setState(() => _groups = groups);
  }

  @override
  Widget build(BuildContext context) {
    final currentSession = widget.trainingProvider.trainingSessions
        .firstWhere((s) => s.id == widget.session.id, orElse: () => widget.session);
    final isDone = currentSession.isDone;
    
    return NeonCard(
      isNeon: widget.isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            leading: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isDone,
                activeColor: widget.isNeon ? AppColors.neonGreen : Colors.blue,
                checkColor: Colors.black,
                side: BorderSide(color: widget.isNeon ? AppColors.neonGreen : Colors.grey, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (val) {
                  if (val != null) widget.trainingProvider.toggleSessionDone(widget.session.id, val);
                },
              ),
            ),
            title: Text(
              currentSession.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.isNeon ? (isDone ? Colors.grey : AppColors.neonGreen) : (isDone ? Colors.grey : null),
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: widget.isNeon ? AppColors.neonPurple : null),
              onPressed: () {
                setState(() { _isExpanded = !_isExpanded; if (_isExpanded) _loadGroups(); });
              },
            ),
            onTap: () {
              setState(() { _isExpanded = !_isExpanded; if (_isExpanded) _loadGroups(); });
            },
          ),
          if (_isExpanded)
            if (_groups.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Nenhum grupo muscular configurado.', style: TextStyle(color: widget.isNeon ? AppColors.neonGreen : null)),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _groups.length,
                separatorBuilder: (_, __) => Divider(height: 2, thickness: 2, color: widget.isNeon ? AppColors.neonPurple.withOpacity(0.3) : null),
                itemBuilder: (context, index) {
                  final smg = _groups[index];
                  final muscleGroup = widget.muscleProvider.muscleGroups.firstWhere(
                    (g) => g.id == smg.muscleGroupId,
                    orElse: () => MuscleGroup(id: '', name: '...', color: '#000', order: 0, createdAt: DateTime.now()),
                  );

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    leading: CircleAvatar(
                      backgroundColor: widget.muscleProvider.getColorFromHex(muscleGroup.color),
                      radius: 14,
                      child: const Icon(Icons.fitness_center, color: Colors.white, size: 14),
                    ),
                    title: Text(muscleGroup.name, style: TextStyle(fontSize: 15, color: widget.isNeon ? Colors.white70 : null)),
                    trailing: ElevatedButton.icon(
                      onPressed: () async {
                        // Verificação de contexto diário
                        final dailyProvider = context.read<DailyContextProvider>();
                        final hasContext = await dailyProvider.hasContextForToday();
                        bool shouldProceed = true;

                        if (!hasContext) {
                          final result = await showDialog<bool>(
                            context: context,
                            barrierDismissible: false, 
                            builder: (ctx) => const DailyContextDialog(),
                          );
                          shouldProceed = result ?? false; 
                        }

                        if (shouldProceed && context.mounted) {
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
                        }
                      },
                      icon: const Icon(Icons.play_arrow, size: 16),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: const Size(80, 32),
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

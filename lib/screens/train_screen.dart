import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/workout_timer_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/daily_context_provider.dart';
import '../providers/running_provider.dart';
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
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Finalizar Treino do Dia?'),
                        content: Text('Tempo total: $totalTime\nIsso irá zerar o cronômetro geral.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
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
      body: SafeArea(
        child: Consumer4<TrainingSessionProvider, MuscleGroupProvider, ThemeProvider, RunningProvider>(
        builder: (context, trainingProvider, muscleProvider, themeProvider, runningProvider, _) {
          final sessions = trainingProvider.trainingSessions;
          final isNeon = themeProvider.isNeon;
          final runProgress = runningProvider.progress;

          // CARREGAR A SESSÃO SUGERIDA
          final suggestedRun = runningProvider.getSessionForLevel(runProgress?.currentLevel ?? 1);

          if (sessions.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // --- CARD DE CORRIDA ---
                NeonCard(
                  isNeon: isNeon,
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_run, color: isNeon ? AppColors.neonGreen : Colors.orange, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            "Treino de Corrida",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isNeon ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Text(
                        "Nível ${suggestedRun.level} • ${suggestedRun.description}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? AppColors.neonPurple : Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Aquecimento: ${suggestedRun.warmupMinutes} min\n"
                        "Série: ${suggestedRun.repetitions}x (${suggestedRun.runSeconds}s Trote / ${suggestedRun.walkSeconds}s Caminhada)\n"
                        "Total Est.: ~${(suggestedRun.totalTimeSeconds/60).toStringAsFixed(0)} min",
                        style: TextStyle(fontSize: 13, height: 1.4, color: isNeon ? Colors.grey[400] : Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.play_circle_filled),
                          label: const Text("Iniciar Corrida"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isNeon ? AppColors.neonGreen : Colors.orange,
                            foregroundColor: isNeon ? Colors.black : Colors.white,
                          ),
                          onPressed: () {
                            // Abre o timer de corrida
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActiveRunningScreen(session: suggestedRun),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'Configure seus treinos na aba "Configuração"',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // --- CARD DE CORRIDA (NOVO) ---
              NeonCard(
                isNeon: isNeon,
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_run, color: isNeon ? AppColors.neonGreen : Colors.orange, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          "Treino de Corrida",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isNeon ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Text(
                      "Nível ${suggestedRun.level} • ${suggestedRun.description}",
                      style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? AppColors.neonPurple : Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Aquecimento: ${suggestedRun.warmupMinutes} min\n"
                      "Série: ${suggestedRun.repetitions}x (${suggestedRun.runSeconds}s Trote / ${suggestedRun.walkSeconds}s Caminhada)\n"
                      "Total Est.: ~${(suggestedRun.totalTimeSeconds/60).toStringAsFixed(0)} min",
                      style: TextStyle(fontSize: 13, height: 1.4, color: isNeon ? Colors.grey[400] : Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.play_circle_filled),
                        label: const Text("Iniciar Corrida"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isNeon ? AppColors.neonGreen : Colors.orange,
                          foregroundColor: isNeon ? Colors.black : Colors.white,
                        ),
                        onPressed: () {
                          // Abre o timer de corrida
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActiveRunningScreen(session: suggestedRun),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Título ou Separador Opcional
              if (sessions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text("Musculação", style: Theme.of(context).textTheme.titleMedium),
                ),

              // Lista de Sessões de Musculação
              ...sessions.map((session) {
                return _TrainingSessionCard(
                  session: session,
                  trainingProvider: trainingProvider,
                  muscleProvider: muscleProvider,
                  isNeon: isNeon,
                );
              }).toList(),
            ],
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
    // Atualiza o estado da sessão a partir do provider
    final currentSession = widget.trainingProvider.trainingSessions
        .firstWhere((s) => s.id == widget.session.id, orElse: () => widget.session);
    final isDone = currentSession.isDone;

    return NeonCard(
      isNeon: widget.isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // CABEÇALHO DO CARD (TREINO)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            
            // CHECKBOX NO NÍVEL DO TREINO
            leading: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isDone,
                activeColor: widget.isNeon ? AppColors.neonGreen : Colors.blue,
                checkColor: Colors.black,
                side: BorderSide(
                  color: widget.isNeon ? AppColors.neonGreen : Colors.grey,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (val) {
                  if (val != null) {
                    widget.trainingProvider.toggleSessionDone(currentSession.id, val);
                  }
                },
              ),
            ),

            title: Text(
              currentSession.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.isNeon 
                    ? (isDone ? Colors.grey : AppColors.neonGreen) // Fica cinza se feito
                    : (isDone ? Colors.grey : null),
                decoration: isDone ? TextDecoration.lineThrough : null, // Risco se feito
              ),
            ),
            
            // Botão de expandir
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: widget.isNeon ? AppColors.neonPurple : null,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) _loadGroups();
                });
              },
            ),
            // Tocar no corpo também expande
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) _loadGroups();
              });
            },
          ),

          // LISTA DE GRUPOS MUSCULARES (SEM CHECKBOX)
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
                separatorBuilder: (_, __) => Divider(
                  height: 2, 
                  thickness: 2, 
                  color: widget.isNeon ? AppColors.neonPurple.withOpacity(0.3) : null,
                ),
                itemBuilder: (context, index) {
                  final smg = _groups[index];
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    // Ícone do grupo apenas visual
                    leading: CircleAvatar(
                      backgroundColor: widget.muscleProvider
                          .getColorFromHex(muscleGroup.color),
                      radius: 14,
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    title: Text(
                      muscleGroup.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: widget.isNeon ? Colors.white70 : null,
                      ),
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () async {
                        // 1. LÓGICA DE CONTEXTO DIÁRIO
                        final dailyProvider = context.read<DailyContextProvider>();
                        
                        // --- COMENTEI A VERIFICAÇÃO ABAIXO PARA APARECER SEMPRE NOS TESTES ---
                        final hasContext = await dailyProvider.hasContextForToday();
                        
                        // Define como FALSE para forçar o aparecimento do menu
                        //final hasContext = false;

                        bool shouldProceed = true;

                        if (!hasContext && mounted) {
                          // Abre o Dialog e espera o resultado
                          final result = await showDialog<bool>(
                            context: context,
                            barrierDismissible: false, 
                            builder: (ctx) => const DailyContextDialog(),
                          );
                          shouldProceed = result ?? false;
                        }

                        if (shouldProceed && mounted) {
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
                        backgroundColor: widget.isNeon
                            ? AppColors.neonPurple
                            : Theme.of(context).primaryColor,
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

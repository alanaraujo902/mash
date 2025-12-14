import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/workout_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<HistorySessionDTO>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _historyFuture = context.read<WorkoutProvider>().getFullHierarchicalHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;

    // REMOVIDO: Scaffold e AppBar - agora é apenas o conteúdo
    return Column(
      children: [
        // Barra simples com botão de refresh
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
            label: const Text("Atualizar"),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<HistorySessionDTO>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final sessions = snapshot.data ?? [];

          if (sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_edu,
                    size: 64,
                    color: isNeon ? Colors.grey[700] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum registro encontrado.',
                    style: TextStyle(
                      color: isNeon ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return _HistorySessionCard(session: session, isNeon: isNeon);
            },
          );
        },
          ),
        ),
      ],
    );
  }
}

// --- CARD DA SESSÃO DE TREINO (NÍVEL 1) ---
class _HistorySessionCard extends StatefulWidget {
  final HistorySessionDTO session;
  final bool isNeon;

  const _HistorySessionCard({
    Key? key,
    required this.session,
    required this.isNeon,
  }) : super(key: key);

  @override
  State<_HistorySessionCard> createState() => _HistorySessionCardState();
}

class _HistorySessionCardState extends State<_HistorySessionCard> {
  // O card começa expandido para facilitar a visualização
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return NeonCard(
      isNeon: widget.isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // TÍTULO DA SESSÃO (TOGGLE)
          ListTile(
            title: Text(
              widget.session.sessionName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: widget.isNeon ? AppColors.neonGreen : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: widget.isNeon ? AppColors.neonPurple : null,
              ),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
            onTap: () => setState(() => _isExpanded = !_isExpanded),
          ),

          // LISTA DE GRUPOS MUSCULARES (NÍVEL 2)
          if (_isExpanded)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.session.muscleGroups.length,
              separatorBuilder: (_, __) => Divider(
                height: 1, 
                thickness: 1, 
                color: widget.isNeon ? AppColors.neonPurple.withOpacity(0.3) : Colors.grey[300],
              ),
              itemBuilder: (context, index) {
                final group = widget.session.muscleGroups[index];
                return _HistoryGroupTile(group: group, isNeon: widget.isNeon);
              },
            ),
        ],
      ),
    );
  }
}

// --- TILE DO GRUPO MUSCULAR (NÍVEL 2) ---
class _HistoryGroupTile extends StatelessWidget {
  final HistoryMuscleGroupDTO group;
  final bool isNeon;

  const _HistoryGroupTile({
    required this.group,
    required this.isNeon,
  });

  @override
  Widget build(BuildContext context) {
    final groupColor = context.read<MuscleGroupProvider>().getColorFromHex(group.color);

    return Theme(
      // Remove linhas padrão do ExpansionTile
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        leading: CircleAvatar(
          backgroundColor: groupColor,
          radius: 14,
          child: const Icon(Icons.fitness_center, size: 14, color: Colors.white),
        ),
        title: Text(
          group.groupName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isNeon ? Colors.white : Colors.black87,
          ),
        ),
        children: group.exercises.map((exercise) {
          return _HistoryExerciseTile(exercise: exercise, isNeon: isNeon);
        }).toList(),
      ),
    );
  }
}

// --- TILE DO EXERCÍCIO (NÍVEL 3) ---
class _HistoryExerciseTile extends StatelessWidget {
  final HistoryExerciseDTO exercise;
  final bool isNeon;

  const _HistoryExerciseTile({
    required this.exercise,
    required this.isNeon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Fundo levemente diferente para distinguir nível 3
      color: isNeon ? Colors.white.withOpacity(0.02) : Colors.grey.withOpacity(0.03),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 32, right: 16), // Indentação
          title: Text(
            exercise.exerciseName,
            style: TextStyle(
              fontSize: 15,
              color: isNeon ? Colors.grey[300] : Colors.black87,
            ),
          ),
          leading: Icon(
            Icons.show_chart, 
            size: 18, 
            color: isNeon ? AppColors.neonPurple : Colors.blueGrey,
          ),
          iconColor: isNeon ? AppColors.neonGreen : null,
          collapsedIconColor: isNeon ? Colors.grey : null,
          
          // CONTEÚDO: LISTA DE REGISTROS (NÍVEL 4)
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: exercise.records.map((record) {
                  return _HistoryRecordRow(record: record, isNeon: isNeon);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- LINHA DE REGISTRO DE DADOS (DATA + CARGAS) ---
class _HistoryRecordRow extends StatelessWidget {
  final ExerciseRecordDTO record;
  final bool isNeon;

  const _HistoryRecordRow({
    Key? key,
    required this.record,
    required this.isNeon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yy');
    
    String volumeText;
    if (record.totalVolume >= 1000) {
      volumeText = '${(record.totalVolume / 1000).toStringAsFixed(2)}t';
    } else {
      volumeText = '${record.totalVolume.toStringAsFixed(0)}kg';
    }
    
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha de Resumo (Data | Volume | Max)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    dateFormat.format(record.date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isNeon ? AppColors.neonGreen : Colors.blue[800],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('•', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  const SizedBox(width: 8),
                  Text(
                    'Vol: $volumeText',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isNeon ? Colors.grey[400] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Text(
                'Max: ${record.maxWeight.toStringAsFixed(1).replaceAll('.0', '')}kg',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isNeon ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 6),
          
          // Chips de Séries
          if (record.sets.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: record.sets.map((setInfo) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge da Série
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isNeon ? AppColors.neonPurple.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isNeon ? AppColors.neonPurple.withOpacity(0.3) : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          setInfo.performance,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isNeon ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 8),

                      // Texto do Feedback
                      if (setInfo.feedbackSummary != null)
                        Expanded(
                          child: Text(
                            setInfo.feedbackSummary!,
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: setInfo.hasLimiters 
                                  ? (isNeon ? Colors.orangeAccent : Colors.deepOrange) 
                                  : (isNeon ? Colors.grey[500] : Colors.grey[600]),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
            const Text(
              "Resumo simples",
              style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            
          Divider(
            height: 12,
            thickness: 0.5,
            color: isNeon ? Colors.white10 : Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
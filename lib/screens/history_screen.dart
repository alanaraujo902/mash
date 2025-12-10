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
  late Future<List<MuscleGroupHistoryDTO>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _historyFuture = context.read<WorkoutProvider>().getHistoryOrganizedByGroup();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico por Exercício'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          )
        ],
      ),
      body: FutureBuilder<List<MuscleGroupHistoryDTO>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final groups = snapshot.data ?? [];

          if (groups.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
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
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return _MuscleGroupHistoryCard(group: group, isNeon: isNeon);
            },
          );
        },
      ),
    );
  }
}

class _MuscleGroupHistoryCard extends StatelessWidget {
  final MuscleGroupHistoryDTO group;
  final bool isNeon;

  const _MuscleGroupHistoryCard({
    Key? key,
    required this.group,
    required this.isNeon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupColor = context.read<MuscleGroupProvider>().getColorFromHex(group.color);

    return NeonCard(
      isNeon: isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CABEÇALHO DO GRUPO MUSCULAR
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isNeon ? AppColors.neonPurple.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: groupColor,
                  radius: 16,
                  child: const Icon(Icons.fitness_center, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  group.groupName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isNeon ? AppColors.neonGreen : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // LISTA DE EXERCÍCIOS (TOGGLES)
          ...group.exercises.map((exercise) {
            return Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  exercise.exerciseName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isNeon ? Colors.white : Colors.black87,
                  ),
                ),
                leading: Icon(
                  Icons.show_chart, 
                  color: isNeon ? AppColors.neonPurple : Colors.blueGrey,
                  size: 20,
                ),
                iconColor: isNeon ? AppColors.neonGreen : null,
                collapsedIconColor: isNeon ? Colors.grey : null,
                children: [
                  Container(
                    width: double.infinity,
                    color: isNeon ? Colors.black26 : Colors.grey.shade50,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: exercise.records.map((record) {
                        return _HistoryRecordRow(record: record, isNeon: isNeon);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

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
    
    // Formatação da Tonelagem
    String volumeText;
    if (record.totalVolume >= 1000) {
      volumeText = '${(record.totalVolume / 1000).toStringAsFixed(2)}t';
    } else {
      volumeText = '${record.totalVolume.toStringAsFixed(0)}kg';
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LINHA SUPERIOR: Data + Volume (Esq)  |  Max Weight (Dir)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // LADO ESQUERDO: Data e Volume
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
                  Text(
                    '•', // Separador
                    style: TextStyle(
                      fontSize: 10,
                      color: isNeon ? Colors.grey[600] : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Vol: $volumeText', // <--- NOVO: VOLUME AQUI
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isNeon ? Colors.grey[400] : Colors.grey[700],
                    ),
                  ),
                ],
              ),

              // LADO DIREITO: Carga Máxima
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
          
          // CHIPS COM AS SÉRIES
          if (record.setDetails.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: record.setDetails.map((setInfo) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isNeon ? AppColors.neonPurple.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isNeon ? AppColors.neonPurple.withOpacity(0.3) : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    setInfo,
                    style: TextStyle(
                      fontSize: 11,
                      color: isNeon ? Colors.white : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            )
          else
            const Text(
              "Resumo simples (antigo)",
              style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            
          Divider(
            height: 16,
            thickness: 0.5,
            color: isNeon ? Colors.white10 : Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}

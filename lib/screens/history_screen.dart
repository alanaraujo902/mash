import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/workout_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<WorkoutSessionHistoryDTO>> _historyFuture;

  @override
  void initState() {
    super.initState();
    // Carrega o histórico ao iniciar
    _historyFuture = context.read<WorkoutProvider>().getFullHistory();
  }

  Future<void> _refresh() async {
    setState(() {
      _historyFuture = context.read<WorkoutProvider>().getFullHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Treinos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          )
        ],
      ),
      body: FutureBuilder<List<WorkoutSessionHistoryDTO>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_toggle_off,
                    size: 64,
                    color: isNeon ? Colors.grey[700] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum treino finalizado ainda.',
                    style: TextStyle(
                      color: isNeon ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final session = history[index];
                return _HistoryCard(session: session, isNeon: isNeon);
              },
            ),
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final WorkoutSessionHistoryDTO session;
  final bool isNeon;

  const _HistoryCard({
    Key? key,
    required this.session,
    required this.isNeon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy • HH:mm');
    final formattedDate = dateFormat.format(session.date);

    return NeonCard(
      isNeon: isNeon,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CABEÇALHO DO CARD (Data e Nome)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: isNeon ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${session.sessionName} - ${session.groupName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isNeon ? AppColors.neonGreen : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: isNeon ? AppColors.neonPurple : Colors.green,
              ),
            ],
          ),
          
          Divider(
            height: 24, 
            color: isNeon ? Colors.white24 : Colors.grey[300],
          ),

          // LISTA DE EXERCÍCIOS
          ...session.exercises.map((ex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // Mais espaçamento
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOME DO EXERCÍCIO
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 4,
                        height: 14,
                        decoration: BoxDecoration(
                          color: isNeon ? AppColors.neonPurple : Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        ex.exerciseName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isNeon ? Colors.white : Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      // Total Tonelagem (Opcional, discreto)
                      Text(
                        'Vol: ${(ex.totalVolume / 1000).toStringAsFixed(1)}t',
                        style: TextStyle(
                           fontSize: 11,
                           color: isNeon ? Colors.grey[500] : Colors.grey[600],
                        ),
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 6),

                  // LISTA DE SETS (Chips ou texto formatado)
                  if (ex.setDetails.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: ex.setDetails.map((setInfo) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isNeon ? Colors.white.withOpacity(0.05) : Colors.grey[100],
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isNeon ? Colors.white10 : Colors.grey[300]!,
                            ),
                          ),
                          child: Text(
                            setInfo, // Ex: "10x 20kg"
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isNeon ? AppColors.neonGreen : Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Text(
                      "Sem detalhes registrados",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
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


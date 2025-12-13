import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/recovery_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({Key? key}) : super(key: key);

  Future<void> _selectDateAndRecover(
    BuildContext context,
    String muscleGroupId,
    RecoveryProvider recoveryProvider,
    bool isNeon,
  ) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 7)),
      builder: (context, child) {
        if (isNeon) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.neonPurple,
                onPrimary: Colors.white,
                surface: AppColors.neonCard,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: AppColors.neonBackground,
            ),
            child: child!,
          );
        }
        return child!;
      },
    );

    if (pickedDate != null) {
      // Ajusta a hora para o momento atual, para o cálculo de horas ficar mais preciso
      final finalDate = DateTime(
        pickedDate.year, 
        pickedDate.month, 
        pickedDate.day, 
        now.hour, 
        now.minute
      );

      await recoveryProvider.markAsRecovered(muscleGroupId, finalDate);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recuperação registrada e salva no histórico!')),
        );
      }
    }
  }

  // Helper para formatar a duração (Ex: "2 dias e 4h" ou "36h")
  String _formatDuration(int totalHours) {
    if (totalHours < 24) {
      return "${totalHours}h";
    } else {
      final days = totalHours ~/ 24;
      final hours = totalHours % 24;
      if (hours == 0) return "$days dias";
      return "$days d e ${hours}h";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<MuscleGroupProvider, RecoveryProvider, ThemeProvider>(
      builder: (context, muscleProvider, recoveryProvider, themeProvider, _) {
        final groups = muscleProvider.muscleGroups;
        final isNeon = themeProvider.isNeon;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Recuperação Muscular'),
          ),
          body: SafeArea(
            child: groups.isEmpty
              ? const Center(child: Text('Nenhum grupo muscular cadastrado.'))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final status = recoveryProvider.getStatus(group.id);
              final history = recoveryProvider.getHistory(group.id);

              final bool isRecovered = status?.isRecovered ?? true;
              final DateTime? lastWorkout = status?.lastWorkoutDate;

              final statusColor = isRecovered
                  ? (isNeon ? AppColors.neonGreen : Colors.green)
                  : (isNeon ? Colors.orangeAccent : Colors.orange);

              final groupColor = muscleProvider.getColorFromHex(group.color);

              return NeonCard(
                isNeon: isNeon,
                margin: const EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.zero, // Padding zero para o ExpansionTile funcionar bem
                child: Theme(
                  // Remove as linhas divisórias padrão do ExpansionTile
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    
                    // ÍCONE À ESQUERDA (AVATAR)
                    leading: Container(
                      decoration: isNeon
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: groupColor.withOpacity(0.6),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            )
                          : null,
                      child: CircleAvatar(
                        backgroundColor: groupColor,
                        child: const Icon(Icons.fitness_center, color: Colors.white, size: 20),
                      ),
                    ),

                    // TÍTULO E STATUS ATUAL
                    title: Text(
                      group.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isNeon ? Colors.white : Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              isRecovered ? Icons.check_circle : Icons.warning_amber_rounded,
                              size: 14,
                              color: statusColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isRecovered ? 'Recuperado' : 'Fadiga / Em descanso',
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        if (lastWorkout != null && !isRecovered)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Treinou: ${DateFormat('dd/MM HH:mm').format(lastWorkout)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isNeon ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                          ),
                      ],
                    ),

                    // BOTÃO DE AÇÃO (No canto direito, substituindo a seta padrão se necessário, 
                    // mas aqui vamos deixar a seta e colocar o botão abaixo se expandido ou no trailing customizado)
                    // Vamos usar um Row no trailing para ter a seta E o botão se não recuperado
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isRecovered)
                          ElevatedButton(
                            onPressed: () => _selectDateAndRecover(
                              context,
                              group.id,
                              recoveryProvider,
                              isNeon,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isNeon ? AppColors.neonGreen.withOpacity(0.2) : Colors.green,
                              foregroundColor: isNeon ? AppColors.neonGreen : Colors.white,
                              side: isNeon ? const BorderSide(color: AppColors.neonGreen) : null,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              minimumSize: const Size(60, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('OK', style: TextStyle(fontSize: 12)),
                          ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.expand_more, 
                          color: isNeon ? Colors.grey : Colors.black54,
                        ),
                      ],
                    ),

                    // CONTEÚDO EXPANDIDO (HISTÓRICO)
                    children: [
                      Container(
                        color: isNeon ? Colors.black26 : Colors.grey.shade50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Histórico de Recuperação",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: isNeon ? Colors.grey[400] : Colors.grey[700],
                                ),
                              ),
                            ),
                            if (history.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Sem histórico registrado ainda.",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              )
                            else
                              ...history.map((log) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Data do Treino
                                      Text(
                                        "Treino: ${DateFormat('dd/MM').format(log.fatigueDate)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isNeon ? Colors.white70 : Colors.black87,
                                        ),
                                      ),
                                      // Seta
                                      const Icon(Icons.arrow_right_alt, size: 16, color: Colors.grey),
                                      // Tempo Total
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: isNeon ? AppColors.neonPurple.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          _formatDuration(log.durationInHours),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isNeon ? AppColors.neonPurple : Colors.blue[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
            ),
        );
      },
    );
  }
}
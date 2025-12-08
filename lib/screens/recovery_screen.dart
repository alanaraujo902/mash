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

    // Configura o tema do DatePicker para combinar com o Neon se necessário
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
                primary: AppColors.neonPurple, // Cor do cabeçalho/seleção
                onPrimary: Colors.white,
                surface: AppColors.neonCard, // Fundo do dialog
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
      await recoveryProvider.markAsRecovered(muscleGroupId, pickedDate);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recuperação registrada!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Consumimos também o ThemeProvider
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

              final bool isRecovered = status?.isRecovered ?? true;
              final DateTime? lastWorkout = status?.lastWorkoutDate;

              // Definição de cores baseada no estado e tema
              final statusColor = isRecovered
                  ? (isNeon ? AppColors.neonGreen : Colors.green)
                  : (isNeon ? Colors.orangeAccent : Colors.orange);

              final groupColor = muscleProvider.getColorFromHex(group.color);

              return NeonCard(
                isNeon: isNeon,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                // No tema padrão mantemos a borda colorida como indicador extra
                // No tema neon, o NeonCard já tem borda, então usamos o ícone/texto
                child: Container(
                  decoration: (!isNeon)
                      ? BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: statusColor.withOpacity(0.5),
                              width: 4,
                            ),
                          ),
                        )
                      : null,
                  padding: !isNeon ? const EdgeInsets.only(left: 12) : null,
                  child: Row(
                    children: [
                      // AVATAR DO GRUPO
                      Container(
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
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // INFORMAÇÕES
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isNeon ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Status Row
                            Row(
                              children: [
                                Icon(
                                  isRecovered
                                      ? Icons.check_circle
                                      : Icons.warning_amber_rounded,
                                  size: 16,
                                  color: statusColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isRecovered
                                      ? 'Recuperado'
                                      : 'Fadiga / Em descanso',
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    shadows: isNeon
                                        ? [
                                            Shadow(
                                              color: statusColor.withOpacity(0.6),
                                              blurRadius: 8,
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            if (lastWorkout != null && !isRecovered)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Último: ${DateFormat('dd/MM HH:mm').format(lastWorkout)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isNeon ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // BOTÃO DE AÇÃO
                      if (!isRecovered)
                        ElevatedButton(
                          onPressed: () => _selectDateAndRecover(
                            context,
                            group.id,
                            recoveryProvider,
                            isNeon,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isNeon
                                ? AppColors.neonGreen.withOpacity(0.2)
                                : Colors.green,
                            foregroundColor: isNeon
                                ? AppColors.neonGreen
                                : Colors.white,
                            side: isNeon
                                ? const BorderSide(color: AppColors.neonGreen)
                                : null,
                            elevation: isNeon ? 10 : 2,
                            shadowColor: isNeon
                                ? AppColors.neonGreen.withOpacity(0.5)
                                : null,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text('Recuperado'),
                        )
                      else
                        // Botão visualmente desabilitado/neutro
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isNeon
                                  ? Colors.white12
                                  : Colors.grey.withOpacity(0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 20,
                            color: isNeon ? Colors.white30 : Colors.grey,
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


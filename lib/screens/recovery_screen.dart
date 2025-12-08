import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/recovery_provider.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({Key? key}) : super(key: key);

  Future<void> _selectDateAndRecover(
    BuildContext context,
    String muscleGroupId,
    RecoveryProvider recoveryProvider,
  ) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 7)),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperação Muscular'),
      ),
      body: Consumer2<MuscleGroupProvider, RecoveryProvider>(
        builder: (context, muscleProvider, recoveryProvider, _) {
          final groups = muscleProvider.muscleGroups;

          if (groups.isEmpty) {
            return const Center(child: Text('Nenhum grupo muscular cadastrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final status = recoveryProvider.getStatus(group.id);

              final bool isRecovered = status?.isRecovered ?? true;
              final DateTime? lastWorkout = status?.lastWorkoutDate;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isRecovered
                        ? Colors.green.withOpacity(0.5)
                        : Colors.orange.withOpacity(0.8),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                muscleProvider.getColorFromHex(group.color),
                            child: const Icon(
                              Icons.fitness_center,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  group.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      isRecovered
                                          ? Icons.check_circle
                                          : Icons.warning_amber_rounded,
                                      size: 14,
                                      color: isRecovered ? Colors.green : Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isRecovered
                                          ? 'Recuperado'
                                          : 'Fadiga / Em descanso',
                                      style: TextStyle(
                                        color:
                                            isRecovered ? Colors.green : Colors.orange,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                if (lastWorkout != null && !isRecovered)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Último treino: ${DateFormat('dd/MM HH:mm').format(lastWorkout)}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (!isRecovered)
                            ElevatedButton(
                              onPressed: () => _selectDateAndRecover(
                                context,
                                group.id,
                                recoveryProvider,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: const Text('Recuperado'),
                            )
                          else
                            OutlinedButton(
                              onPressed: null, // Desabilitado pois já está recuperado
                              child: const Text('OK'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


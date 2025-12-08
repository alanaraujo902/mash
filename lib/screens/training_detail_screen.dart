import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../database/database.dart';
import 'exercise_list_screen.dart';

class TrainingDetailScreen extends StatefulWidget {
  final String sessionId;

  const TrainingDetailScreen({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<TrainingSessionProvider>().setActiveSession(widget.sessionId);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Sessão'),
      ),
      body: SafeArea(
        child: Consumer2<TrainingSessionProvider, MuscleGroupProvider>(
        builder: (context, trainingProvider, muscleProvider, _) {
          final sessionMuscleGroups =
              trainingProvider.getSessionMuscleGroups(widget.sessionId);

          if (sessionMuscleGroups.isEmpty && _isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (sessionMuscleGroups.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum grupo muscular',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Adicione grupos musculares a esta sessão',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sessionMuscleGroups.length,
                itemBuilder: (context, index) {
              final smg = sessionMuscleGroups[index];
              final muscleGroup = muscleProvider.muscleGroups
                  .firstWhere((g) => g.id == smg.muscleGroupId);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor:
                        muscleProvider.getColorFromHex(muscleGroup.color),
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    muscleGroup.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'remove') {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('Remover Grupo'),
                                content: Text(
                                  'Tem certeza que deseja remover "${muscleGroup.name}" desta sessão?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await trainingProvider.removeMuscleGroupFromSession(smg.id);
                                      if (dialogContext.mounted) {
                                        Navigator.of(dialogContext).pop();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Remover'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'remove',
                            child: Row(
                              children: [
                                Icon(Icons.remove_circle_outline, size: 20, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Remover da sessão', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseListScreen(
                          sessionMuscleGroupId: smg.id,
                          muscleGroupName: muscleGroup.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () => _showAddGroupDialog(
                    context,
                    trainingProvider,
                    muscleProvider,
                    sessionMuscleGroups,
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
        ),
      ),
    );
  }

  Future<void> _showAddGroupDialog(
    BuildContext context,
    TrainingSessionProvider trainingProvider,
    MuscleGroupProvider muscleProvider,
    List<SessionMuscleGroup> currentSessionGroups,
  ) async {
    final currentGroupIds = currentSessionGroups
        .map((smg) => smg.muscleGroupId)
        .toSet();
    final availableGroups = muscleProvider.muscleGroups
        .where((group) => !currentGroupIds.contains(group.id))
        .toList();

    await showDialog(
      context: context,
      builder: (dialogContext) => _AddGroupDialog(
        sessionId: widget.sessionId,
        availableGroups: availableGroups,
        trainingProvider: trainingProvider,
        muscleProvider: muscleProvider,
      ),
    );
  }
}

class _AddGroupDialog extends StatefulWidget {
  final String sessionId;
  final List<MuscleGroup> availableGroups;
  final TrainingSessionProvider trainingProvider;
  final MuscleGroupProvider muscleProvider;

  const _AddGroupDialog({
    required this.sessionId,
    required this.availableGroups,
    required this.trainingProvider,
    required this.muscleProvider,
  });

  @override
  State<_AddGroupDialog> createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<_AddGroupDialog> {
  Future<void> _showAddMuscleGroupDialog() async {
    final nameController = TextEditingController();
    String selectedColor = '#FF6B6B';
    
    final availableColors = [
      '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8',
      '#F7DC6F', '#BB8FCE', '#85C1E2', '#F8B88B', '#FF6B9D',
      '#C44569', '#F8B500', '#10AC84', '#EE5A6F', '#0ABDE3',
    ];

    await showDialog(
      context: context,
      builder: (newGroupDialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Novo Grupo Muscular'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Nome do grupo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cor:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: availableColors.map((colorHex) {
                    final color = _hexToColor(colorHex);
                    final isSelected = selectedColor == colorHex;
                    return GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          selectedColor = colorHex;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(newGroupDialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final groupName = nameController.text.trim();
                if (groupName.isNotEmpty) {
                  await widget.muscleProvider.addMuscleGroup(
                    groupName,
                    selectedColor,
                  );
                  if (newGroupDialogContext.mounted) {
                    Navigator.of(newGroupDialogContext).pop();
                  }
                  // Adicionar o novo grupo à sessão automaticamente
                  final newGroups = widget.muscleProvider.muscleGroups;
                  try {
                    final newGroup = newGroups.firstWhere(
                      (g) => g.name == groupName,
                    );
                    await widget.trainingProvider.addMuscleGroupToSession(
                      widget.sessionId,
                      newGroup.id,
                    );
                  } catch (e) {
                    // Grupo não encontrado, ignorar
                  }
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
    
    nameController.dispose();
  }

  Color _hexToColor(String hexColor) {
    final hexString = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hexString', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Grupo Muscular'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.availableGroups.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Todos os grupos musculares já estão nesta sessão.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                ...widget.availableGroups.map((group) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: widget.muscleProvider.getColorFromHex(group.color),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text(group.name),
                      onTap: () async {
                        await widget.trainingProvider.addMuscleGroupToSession(
                          widget.sessionId,
                          group.id,
                        );
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  );
                }).toList(),
              const Divider(height: 32),
              OutlinedButton.icon(
                onPressed: _showAddMuscleGroupDialog,
                icon: const Icon(Icons.add),
                label: const Text('Criar novo grupo'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}

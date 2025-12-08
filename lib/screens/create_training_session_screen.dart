import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';

class CreateTrainingSessionScreen extends StatefulWidget {
  const CreateTrainingSessionScreen({Key? key}) : super(key: key);

  @override
  State<CreateTrainingSessionScreen> createState() =>
      _CreateTrainingSessionScreenState();
}

class _CreateTrainingSessionScreenState
    extends State<CreateTrainingSessionScreen> {
  final _nameController = TextEditingController();
  final List<String> _selectedMuscleGroups = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _showAddMuscleGroupDialog(
    BuildContext context,
    MuscleGroupProvider muscleProvider,
  ) async {
    final nameController = TextEditingController();
    String selectedColor = '#FF6B6B';
    
    // Lista de cores disponíveis
    final availableColors = [
      '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8',
      '#F7DC6F', '#BB8FCE', '#85C1E2', '#F8B88B', '#FF6B9D',
      '#C44569', '#F8B500', '#10AC84', '#EE5A6F', '#0ABDE3',
    ];

    await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
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
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final groupName = nameController.text.trim();
                if (groupName.isNotEmpty) {
                  await muscleProvider.addMuscleGroup(
                    groupName,
                    selectedColor,
                  );
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                  // Selecionar o novo grupo automaticamente
                  // O provider já atualizou a lista após addMuscleGroup
                  final newGroups = muscleProvider.muscleGroups;
                  try {
                    final newGroup = newGroups.firstWhere(
                      (g) => g.name == groupName,
                    );
                    if (mounted) {
                      setState(() {
                        if (!_selectedMuscleGroups.contains(newGroup.id)) {
                          _selectedMuscleGroups.add(newGroup.id);
                        }
                      });
                    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Sessão de Treino'),
      ),
      body: Consumer2<TrainingSessionProvider, MuscleGroupProvider>(
        builder: (context, trainingProvider, muscleProvider, _) {
          final muscleGroups = muscleProvider.muscleGroups;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome da Sessão',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Ex: Sessão A, Sessão B...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Grupos Musculares',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...muscleGroups.map((group) {
                      final isSelected =
                          _selectedMuscleGroups.contains(group.id);
                      return FilterChip(
                        label: Text(group.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedMuscleGroups.add(group.id);
                            } else {
                              _selectedMuscleGroups.remove(group.id);
                            }
                          });
                        },
                      );
                    }).toList(),
                    ActionChip(
                      avatar: const Icon(Icons.add, size: 18),
                      label: const Text('Adicionar grupo'),
                      onPressed: () => _showAddMuscleGroupDialog(
                        context,
                        muscleProvider,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedMuscleGroups.isEmpty ||
                            _nameController.text.isEmpty
                        ? null
                        : () async {
                            await trainingProvider.createTrainingSession(
                              _nameController.text,
                              _selectedMuscleGroups,
                            );
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                    child: const Text('Criar Sessão'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

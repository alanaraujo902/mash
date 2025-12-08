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
                  children: muscleGroups.map((group) {
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

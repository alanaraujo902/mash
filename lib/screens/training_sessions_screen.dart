import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/theme_provider.dart';
import '../database/database.dart';
import '../utils/app_colors.dart';
import '../widgets/neon_card.dart';
import 'create_training_session_screen.dart';
import 'training_detail_screen.dart';

class TrainingSessionsScreen extends StatelessWidget {
  const TrainingSessionsScreen({Key? key}) : super(key: key);

  Future<void> _editSessionName(
    BuildContext context,
    TrainingSession session,
    TrainingSessionProvider provider,
  ) async {
    final nameController = TextEditingController(text: session.name);
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Nome da Sessão'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.trim().isNotEmpty) {
      await provider.updateTrainingSession(
        session.id,
        nameController.text.trim(),
        session.description,
      );
    }
    
    nameController.dispose();
  }

  // Novo método para mostrar o diálogo de tema
  void _showThemeSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_auto),
                title: const Text('Tema do Sistema'),
                trailing: themeProvider.currentTheme == ThemeType.dark &&
                        themeProvider.themeMode == ThemeMode.system
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  themeProvider.setSystemTheme();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text('Tema Claro'),
                trailing: themeProvider.currentTheme == ThemeType.light
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  themeProvider.setTheme(ThemeType.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Tema Escuro'),
                trailing: themeProvider.currentTheme == ThemeType.dark &&
                        !themeProvider.isNeon
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  themeProvider.setTheme(ThemeType.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.color_lens,
                  color: AppColors.neonPurple,
                ),
                title: const Text('Cyber Neon'),
                trailing: themeProvider.currentTheme == ThemeType.neon
                    ? Icon(Icons.check, color: AppColors.neonGreen)
                    : null,
                onTap: () {
                  themeProvider.setTheme(ThemeType.neon);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração de Treinos'),
        elevation: 0,
        actions: [
          // ÍCONE DE CONFIGURAÇÃO DE TEMA
          IconButton(
            icon: const Icon(Icons.brightness_6), // Ícone meio sol/meio lua
            tooltip: 'Alterar Tema',
            onPressed: () => _showThemeSettings(context),
          ),
        ],
      ),
      body: Consumer3<TrainingSessionProvider, MuscleGroupProvider, ThemeProvider>(
        builder: (context, trainingProvider, muscleProvider, themeProvider, _) {
          final sessions = trainingProvider.trainingSessions;
          final isNeon = themeProvider.isNeon;

          if (sessions.isEmpty) {
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
                    'Nenhuma sessão de treino',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crie sua primeira sessão de treino',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
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
              return NeonCard(
                isNeon: isNeon,
                margin: const EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    session.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    'Criado em ${session.createdAt.day}/${session.createdAt.month}/${session.createdAt.year}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editSessionName(context, session, trainingProvider);
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Excluir Sessão'),
                                content: Text(
                                  'Tem certeza que deseja excluir "${session.name}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await trainingProvider.deleteTrainingSession(session.id);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 8),
                                Text('Editar nome'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 20, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Excluir', style: TextStyle(color: Colors.red)),
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
                        builder: (context) =>
                            TrainingDetailScreen(sessionId: session.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTrainingSessionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

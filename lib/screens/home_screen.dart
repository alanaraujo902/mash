import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import 'training_sessions_screen.dart';
import 'evolution_screen.dart';
import 'train_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MuscleGroupProvider>().loadMuscleGroups();
      context.read<TrainingSessionProvider>().loadTrainingSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          TrainScreen(),            // 0: Tela Principal de Execução
          TrainingSessionsScreen(), // 1: Antiga "Treinos", agora Configuração
          EvolutionScreen(),        // 2: Evolução
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.play_circle_fill),
            label: 'Treinar', // Nova aba
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Configuração', // Renomeado de "Treinos"
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Evolução',
          ),
        ],
      ),
    );
  }
}

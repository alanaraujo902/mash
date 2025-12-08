import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import 'training_sessions_screen.dart';
import 'evolution_screen.dart';
import 'train_screen.dart';
import 'recovery_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex; // Adicione isso para permitir navegação direta

  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Usa o índice inicial
    Future.microtask(() {
      context.read<MuscleGroupProvider>().loadMuscleGroups();
      context.read<TrainingSessionProvider>().loadTrainingSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
        index: _selectedIndex,
        children: const [
          TrainScreen(),            // 0
          TrainingSessionsScreen(), // 1
          EvolutionScreen(),        // 2
          RecoveryScreen(),         // 3: Nova Tela
        ],
        ),
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
          NavigationDestination(
            // Nova aba
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services),
            label: 'Recuperação',
          ),
        ],
      ),
    );
  }
}

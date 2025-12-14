import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import 'training_sessions_screen.dart';
import 'train_screen.dart';
import 'recovery_screen.dart';
import 'history_evolution_screen.dart'; // NOVA COMBINADA
import 'diet_screen.dart';              // NOVA DIETA

class HomeScreen extends StatefulWidget {
  final int initialIndex; 

  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; 
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
          HistoryEvolutionScreen(), // 1: Histórico + Evolução
          DietScreen(),             // 2: Nova Aba Dieta
          TrainingSessionsScreen(), // 3: Config
          RecoveryScreen(),         // 4
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
        height: 70, 
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.play_circle_fill),
            label: 'Treinar',
          ),
          NavigationDestination(
            icon: Icon(Icons.history), 
            label: 'Progresso', // Nome unificado
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant), // Ícone de Dieta
            label: 'Dieta',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Config', 
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services),
            label: 'Recup.',
          ),
        ],
      ),
    );
  }
}
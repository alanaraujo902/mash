import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/training_session_provider.dart';
import '../providers/muscle_group_provider.dart';
import 'training_sessions_screen.dart';
import 'evolution_screen.dart';
import 'train_screen.dart';
import 'recovery_screen.dart';
import 'history_screen.dart'; // <--- IMPORTAR NOVA TELA

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
          HistoryScreen(),          // 1: <--- NOVA TELA AQUI (Reordenando para ficar lógico)
          TrainingSessionsScreen(), // 2
          EvolutionScreen(),        // 3
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
        // Altura menor para caber 5 itens confortavelmente
        height: 70, 
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.play_circle_fill),
            label: 'Treinar',
          ),
          NavigationDestination(
            icon: Icon(Icons.history), // <--- NOVO ÍCONE
            label: 'Histórico',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Config', 
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Evolução',
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

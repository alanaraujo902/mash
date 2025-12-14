import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'evolution_screen.dart';

class HistoryEvolutionScreen extends StatelessWidget {
  const HistoryEvolutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Progresso'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Histórico'),
              Tab(text: 'Evolução'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryScreen(),
            EvolutionScreen(),
          ],
        ),
      ),
    );
  }
}

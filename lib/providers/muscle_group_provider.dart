import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class MuscleGroupProvider extends ChangeNotifier {
  final AppDatabase database;
  List<MuscleGroup> _muscleGroups = [];

  // CORREÇÃO: Variável para impedir execução simultânea
  bool _isLoading = false;

  final List<String> _defaultGroups = [
    'Peito',
    'Peito Superior',
    'Dorso',
    'Trapézio',
    'Ombro',
    'Bíceps',
    'Tríceps',
    'Antebraço',
    'Anterior de Coxa',
    'Posterior de Coxa',
    'Glúteos',
    'Panturrilha',
  ];

  final List<String> _defaultColors = [
    '#FF6B6B', '#D63031', '#98D8C8', '#6c5ce7', '#45B7D1', '#FF6B6B',
    '#4ECDC4', '#F8B88B', '#F7DC6F', '#BB8FCE', '#fd79a8', '#85C1E2',
  ];

  MuscleGroupProvider(this.database);

  List<MuscleGroup> get muscleGroups => _muscleGroups;

  Future<void> loadMuscleGroups() async {
    // CORREÇÃO: Se já estiver carregando, cancela esta chamada
    if (_isLoading) return;

    _isLoading = true;

    try {
      // 1. Carrega o que tem no banco
      _muscleGroups = await database.getAllMuscleGroups();

      // 2. Remove duplicatas existentes (Isso vai limpar o que já está duplicado no seu app)
      await _removeDuplicates();

      // 3. Verifica e cria os grupos padrão que estiverem faltando
      await _ensureDefaultGroupsExist();

      // 4. Recarrega a lista final limpa e atualizada
      _muscleGroups = await database.getAllMuscleGroups();
      notifyListeners();
    } finally {
      // CORREÇÃO: Libera a flag para futuras chamadas
      _isLoading = false;
    }
  }

  Future<void> _removeDuplicates() async {
    // Primeiro recarregamos para ter certeza que temos os dados mais atuais
    final currentList = await database.getAllMuscleGroups();
    final Set<String> seenNames = {};

    for (var group in currentList) {
      if (seenNames.contains(group.name)) {
        // Se já vimos esse nome antes, é uma duplicata -> deletar do banco
        await database.deleteMuscleGroup(group.id);
      } else {
        seenNames.add(group.name);
      }
    }
  }

  Future<void> _ensureDefaultGroupsExist() async {
    // Pega os nomes que já estão no banco atualizados
    final currentGroups = await database.getAllMuscleGroups();
    final existingNames = currentGroups.map((g) => g.name).toSet();

    for (int i = 0; i < _defaultGroups.length; i++) {
      final name = _defaultGroups[i];

      // Só cria se o nome NÃO existir no banco
      if (!existingNames.contains(name)) {
        final group = MuscleGroup(
          id: const Uuid().v4(),
          name: name,
          color: _defaultColors.length > i ? _defaultColors[i] : '#999999',
          order: i,
          createdAt: DateTime.now(),
        );
        await database.insertMuscleGroup(group);
      }
    }
  }

  Future<void> addMuscleGroup(String name, String color) async {
    // Verifica duplicidade antes de adicionar manualmente também
    if (_muscleGroups.any((g) => g.name.toLowerCase() == name.toLowerCase())) {
      return; // Já existe, não faz nada
    }

    final group = MuscleGroup(
      id: const Uuid().v4(),
      name: name,
      color: color,
      order: _muscleGroups.length,
      createdAt: DateTime.now(),
    );
    await database.insertMuscleGroup(group);
    await loadMuscleGroups();
  }

  Future<void> updateMuscleGroup(String id, String name, String color) async {
    final group = _muscleGroups.firstWhere((g) => g.id == id);
    final updated = group.copyWith(name: name, color: color);
    await database.updateMuscleGroup(updated);
    await loadMuscleGroups();
  }

  Future<void> deleteMuscleGroup(String id) async {
    await database.deleteMuscleGroup(id);
    await loadMuscleGroups();
  }

  Color getColorFromHex(String hexColor) {
    try {
      final hexString = hexColor.replaceFirst('#', '');
      return Color(int.parse('FF$hexString', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }
}

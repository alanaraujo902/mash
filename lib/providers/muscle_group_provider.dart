import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class MuscleGroupProvider extends ChangeNotifier {
  final AppDatabase database;
  List<MuscleGroup> _muscleGroups = [];
  
  final List<String> _defaultGroups = [
    'Bíceps',
    'Tríceps',
    'Ombro',
    'Peito',
    'Dorso',
    'Anterior de Coxa',
    'Posterior de Coxa',
    'Panturrilha',
    'Antebraço',
  ];

  final List<String> _defaultColors = [
    '#FF6B6B', // Red
    '#4ECDC4', // Teal
    '#45B7D1', // Blue
    '#FFA07A', // Light Salmon
    '#98D8C8', // Mint
    '#F7DC6F', // Yellow
    '#BB8FCE', // Purple
    '#85C1E2', // Light Blue
    '#F8B88B', // Peach
  ];

  MuscleGroupProvider(this.database);

  List<MuscleGroup> get muscleGroups => _muscleGroups;

  Future<void> loadMuscleGroups() async {
    _muscleGroups = await database.getAllMuscleGroups();
    
    // Se não houver grupos, criar os padrões
    if (_muscleGroups.isEmpty) {
      await _createDefaultGroups();
    }
    
    notifyListeners();
  }

  Future<void> _createDefaultGroups() async {
    for (int i = 0; i < _defaultGroups.length; i++) {
      final group = MuscleGroup(
        id: const Uuid().v4(),
        name: _defaultGroups[i],
        color: _defaultColors[i],
        order: i,
        createdAt: DateTime.now(),
      );
      await database.insertMuscleGroup(group);
    }
    await loadMuscleGroups();
  }

  Future<void> addMuscleGroup(String name, String color) async {
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
    final hexString = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hexString', radix: 16));
  }
}

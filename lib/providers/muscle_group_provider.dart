import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class MuscleGroupProvider extends ChangeNotifier {
  final AppDatabase database;
  List<MuscleGroup> _muscleGroups = [];

  // Lista atualizada com os novos grupos solicitados
  final List<String> _defaultGroups = [
    'Peito',
    'Peito Superior', // Novo
    'Dorso',
    'Trapézio', // Novo
    'Ombro',
    'Bíceps',
    'Tríceps',
    'Antebraço',
    'Anterior de Coxa',
    'Posterior de Coxa',
    'Glúteos', // Novo
    'Panturrilha',
  ];

  // Cores correspondentes (adicionei cores novas para os novos grupos)
  final List<String> _defaultColors = [
    '#FF6B6B', // Peito (Vermelho Claro)
    '#D63031', // Peito Superior (Vermelho Mais Escuro)
    '#98D8C8', // Dorso (Menta)
    '#6c5ce7', // Trapézio (Roxo)
    '#45B7D1', // Ombro (Azul)
    '#FF6B6B', // Bíceps (Reutilizando Vermelho ou mudando para destaque)
    '#4ECDC4', // Tríceps
    '#F8B88B', // Antebraço
    '#F7DC6F', // Anterior Coxa
    '#BB8FCE', // Posterior Coxa
    '#fd79a8', // Glúteos (Rosa)
    '#85C1E2', // Panturrilha
  ];

  MuscleGroupProvider(this.database);

  List<MuscleGroup> get muscleGroups => _muscleGroups;

  Future<void> loadMuscleGroups() async {
    // 1. Carrega o que tem no banco
    _muscleGroups = await database.getAllMuscleGroups();

    // 2. Remove duplicatas existentes (Correção do problema atual)
    await _removeDuplicates();

    // 3. Verifica e cria os grupos padrão que estiverem faltando
    await _ensureDefaultGroupsExist();

    // 4. Recarrega a lista final limpa e atualizada
    _muscleGroups = await database.getAllMuscleGroups();
    notifyListeners();
  }

  Future<void> _removeDuplicates() async {
    final Set<String> seenNames = {};
    for (var group in _muscleGroups) {
      if (seenNames.contains(group.name)) {
        // Se já vimos esse nome antes, é uma duplicata -> deletar do banco
        await database.deleteMuscleGroup(group.id);
      } else {
        seenNames.add(group.name);
      }
    }
  }

  Future<void> _ensureDefaultGroupsExist() async {
    // Pega os nomes que já estão no banco (após a limpeza)
    // Atualizamos a lista local temporariamente para checagem
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

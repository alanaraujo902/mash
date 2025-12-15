import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class DietProvider extends ChangeNotifier {
  final AppDatabase database;
  
  List<Meal> _dailyMeals = [];
  DateTime _selectedDate = DateTime.now();
  UserGoal? _userGoal; // Armazena as metas

  DietProvider(this.database) {
    loadGoals(); // Carrega metas ao iniciar
  }

  List<Meal> get dailyMeals => _dailyMeals;
  DateTime get selectedDate => _selectedDate;
  UserGoal? get userGoal => _userGoal;

  // --- LÓGICA DE PARSEAMENTO (Vírgula e Ponto) ---
  double parseValue(String text) {
    if (text.isEmpty) return 0.0;
    // Troca vírgula por ponto antes de converter
    final cleanText = text.replaceAll(',', '.');
    return double.tryParse(cleanText) ?? 0.0;
  }

  // --- METAS ---
  Future<void> loadGoals() async {
    _userGoal = await database.getUserGoal();
    notifyListeners();
  }

  Future<void> saveGoals({
    required double calories,
    required double carbs,
    required double protein,
    required double fat,
  }) async {
    final goal = UserGoal(
      id: 'main', 
      caloriesTarget: calories,
      carbsTarget: carbs,
      proteinTarget: protein,
      fatTarget: fat
    );
    await database.updateUserGoal(goal);
    _userGoal = goal;
    notifyListeners();
  }

  // --- REFEIÇÕES ---
  Future<void> loadMeals(DateTime date) async {
    _selectedDate = date;
    _dailyMeals = await database.getMealsByDate(date);
    notifyListeners();
  }

  Future<void> addMeal({
    required String calories, // Recebe como String para tratar aqui
    required String carbs,
    required String protein,
    required String totalFat,
    required String saturatedFat,
    required String fiber,
    required String sodium,
    required String calcium,
  }) async {
    final meal = Meal(
      id: const Uuid().v4(),
      date: _selectedDate,
      mealIndex: _dailyMeals.length + 1,
      // Usa o helper parseValue
      calories: parseValue(calories),
      carbs: parseValue(carbs),
      protein: parseValue(protein),
      totalFat: parseValue(totalFat),
      saturatedFat: parseValue(saturatedFat),
      fiber: parseValue(fiber),
      sodium: parseValue(sodium),
      calcium: parseValue(calcium),
    );

    await database.insertMeal(meal);
    await loadMeals(_selectedDate);
  }

  Future<void> deleteMeal(String id) async {
    await database.deleteMeal(id);
    await loadMeals(_selectedDate);
  }

  Map<String, double> get dailyTotals {
    double cal = 0, carb = 0, prot = 0, fat = 0, satFat = 0, fib = 0, sod = 0, calc = 0;
    
    for (var m in _dailyMeals) {
      cal += m.calories;
      carb += m.carbs;
      prot += m.protein;
      fat += m.totalFat;
      satFat += m.saturatedFat;
      fib += m.fiber;
      sod += m.sodium;
      calc += m.calcium;
    }

    return {
      'calories': cal,
      'carbs': carb,
      'protein': prot,
      'totalFat': fat,
      'saturatedFat': satFat,
      'fiber': fib,
      'sodium': sod,
      'calcium': calc,
    };
  }
}
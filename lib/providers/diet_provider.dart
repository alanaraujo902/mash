import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class DietProvider extends ChangeNotifier {
  final AppDatabase database;
  
  List<Meal> _dailyMeals = [];
  DateTime _selectedDate = DateTime.now();

  DietProvider(this.database);

  List<Meal> get dailyMeals => _dailyMeals;
  DateTime get selectedDate => _selectedDate;

  // Carrega refeições da data selecionada
  Future<void> loadMeals(DateTime date) async {
    _selectedDate = date;
    _dailyMeals = await database.getMealsByDate(date);
    notifyListeners();
  }

  Future<void> addMeal({
    required double calories,
    required double carbs,
    required double protein,
    required double totalFat,
    required double saturatedFat,
    required double fiber,
    required double sodium,
    required double calcium,
  }) async {
    final meal = Meal(
      id: const Uuid().v4(),
      date: _selectedDate, // Usa a data selecionada na tela
      mealIndex: _dailyMeals.length + 1, // Auto-incrementa o número da refeição
      calories: calories,
      carbs: carbs,
      protein: protein,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      fiber: fiber,
      sodium: sodium,
      calcium: calcium,
    );

    await database.insertMeal(meal);
    await loadMeals(_selectedDate);
  }

  Future<void> deleteMeal(String id) async {
    await database.deleteMeal(id);
    await loadMeals(_selectedDate);
  }

  // Cálculos de Totais
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

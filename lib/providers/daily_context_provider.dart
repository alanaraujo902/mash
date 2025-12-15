import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class DailyContextProvider extends ChangeNotifier {
  final AppDatabase database;

  DailyContextProvider(this.database);

  // Verifica se já preencheu hoje
  Future<bool> hasContextForToday() async {
    final ctx = await database.getDailyContextByDate(DateTime.now());
    return ctx != null;
  }

  Future<void> saveContext({
    required List<String> sleepTags,
    required List<String> nutritionTags,
    required List<String> stressTags,
    String? notes,
  }) async {
    final entry = DailyContext(
      id: const Uuid().v4(),
      date: DateTime.now(),
      sleepTags: jsonEncode(sleepTags),
      nutritionTags: jsonEncode(nutritionTags),
      stressTags: jsonEncode(stressTags),
      notes: notes,
    );

    await database.insertDailyContext(entry);
    notifyListeners();
  }
}




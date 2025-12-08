import 'package:flutter/material.dart';

enum ThemeType { dark, light, neon }

class ThemeProvider extends ChangeNotifier {
  ThemeType _currentTheme = ThemeType.dark;

  ThemeType get currentTheme => _currentTheme;

  ThemeMode get themeMode {
    switch (_currentTheme) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
      case ThemeType.neon:
        return ThemeMode.dark; // Neon usa base dark
    }
  }

  bool get isDarkMode => _currentTheme == ThemeType.dark;

  bool get isNeon => _currentTheme == ThemeType.neon;

  void setTheme(ThemeType type) {
    _currentTheme = type;
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _currentTheme = isDark ? ThemeType.dark : ThemeType.light;
    notifyListeners();
  }

  void setSystemTheme() {
    // Para simplificar, vamos manter como dark quando "sistema"
    _currentTheme = ThemeType.dark;
    notifyListeners();
  }
}


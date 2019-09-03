import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {
  ThemeData darkTheme = ThemeData.dark();

  ThemeData lightTheme = ThemeData.light();

  ThemeData _themeData;
  bool isDark = false;

  ThemeState() {
    _themeData = darkTheme;
  }

  ThemeData getTheme() => _themeData;

  toggleTheme() {
    if (!isDark) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    isDark = !isDark;
    notifyListeners();
  }
}

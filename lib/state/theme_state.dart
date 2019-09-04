import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {
  ThemeData darkTheme = ThemeData.dark();

  ThemeData lightTheme = ThemeData(
    accentColor: Color(0xfff6f6),
    primaryColor: Color(0xff843c0b),
    canvasColor: Color(0xffff6600),
    scaffoldBackgroundColor: Color(0xffff6f6ef).withOpacity(0.5)
  );

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

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5ED5A8),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B232A),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5ED5A8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1B232A),
      selectedItemColor: Color(0xFF5ED5A8),
      unselectedItemColor: Colors.grey,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF5ED5A8),
    scaffoldBackgroundColor: const Color(0xFF1B232A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B232A),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5ED5A8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1B232A),
      selectedItemColor: Color(0xFF5ED5A8),
      unselectedItemColor: Colors.grey,
    ),
  );
}

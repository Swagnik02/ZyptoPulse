import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  final _storage = const FlutterSecureStorage();

  void _loadTheme() async {
    final theme = await _storage.read(key: "theme");
    if (theme == "dark") {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  void toggleTheme() {
    state = (state == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    _storage.write(
      key: "theme",
      value: state == ThemeMode.dark ? "dark" : "light",
    );
  }
}

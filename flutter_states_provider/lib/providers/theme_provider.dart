import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Establecer el tema para la app
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void changeTheme() {
    // Si es claro cambia al tema oscuro y viceversa
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }
}

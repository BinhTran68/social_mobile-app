import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  ThemeData _currentTheme = ThemeData.dark();

  ThemeData get getAppTheme => _currentTheme;

  set theme(ThemeData theme) {
    _currentTheme = theme;
  }
}

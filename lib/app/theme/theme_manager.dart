import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  ThemeData? _themeData;

  factory ThemeManager() {
    return _instance;
  }

  ThemeManager._internal();

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
  }

  ThemeData? get themeData => _themeData;
}


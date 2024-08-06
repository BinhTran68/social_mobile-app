import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeState get darkTheme => ThemeState(ThemeData.dark().copyWith(
      backgroundColor: const Color(0XFF000000),
      primaryColor: const Color(0XFF3797EF),
      primaryColorLight: const Color(0xFFFFFFFF),
      indicatorColor: const Color(0XFF121212)));

  static ThemeState get lightTheme => ThemeState(ThemeData.light().copyWith(
        backgroundColor: const Color(0XFFFFFFFF),
        primaryColor: const Color(0XFF3797EF),
      ));
}


import 'package:flutter/material.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/consts.dart';

Widget appTextWidget(
    {String? text, double? fontSize, Color? color, FontWeight? fontWeight}) {
  final theme = ThemeManager().themeData;

  return Text(text ?? "",
      style: TextStyle(
          fontSize: fontSize ?? 14,
          color: color ?? theme?.hintColor,
          fontWeight: fontWeight ?? FontWeight.w600));
}

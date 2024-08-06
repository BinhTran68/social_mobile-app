import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';

Widget appTextWidget(
    {String? text, double? fontSize, Color? color, FontWeight? fontWeight}) {
  return Text(text ?? "",
      style: TextStyle(
          fontSize: fontSize ?? 14,
          color: color ?? primaryColor,
          fontWeight: fontWeight ?? FontWeight.w600));
}

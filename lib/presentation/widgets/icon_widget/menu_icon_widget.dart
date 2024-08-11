import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget menuIconWidget({required VoidCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Image.asset("assets/images/Menu.png"),
  );
}

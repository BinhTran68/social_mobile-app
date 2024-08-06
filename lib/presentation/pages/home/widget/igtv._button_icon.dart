import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget iGTVButton({required VoidCallback onPressed}) {
  return IconButton(
      onPressed: onPressed, icon: Image.asset("assets/images/IGTV.png"));
}

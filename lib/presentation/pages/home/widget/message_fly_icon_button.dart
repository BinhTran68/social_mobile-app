import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget messageFlyIconButton({required VoidCallback onPressed}) {
  return IconButton(
      onPressed: onPressed,
      icon: Image.asset("assets/images/message_fly_icon.png"));
}

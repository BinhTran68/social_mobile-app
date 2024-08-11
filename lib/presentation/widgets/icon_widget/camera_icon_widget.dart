import 'package:flutter/material.dart';

Widget cameraIconWidget({VoidCallback? onPressed}) {
  return IconButton(
      icon: Image.asset("assets/images/camera_icon.png"), onPressed: onPressed);
}

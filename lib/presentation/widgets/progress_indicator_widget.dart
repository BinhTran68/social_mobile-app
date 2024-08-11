import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Please wait",
          style: TextStyle(
              color: theme.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        sizeHor(10),
        const CircularProgressIndicator()
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

class ButtonContainerWidget extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? height;
  final VoidCallback? onTapListener;

  const ButtonContainerWidget(
      {super.key,
      this.color = blueColor,
      this.text,
      this.onTapListener,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapListener,
      child: Container(
        width: double.infinity,
        height: height,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: appTextWidget(text: text),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget titleAndStartOrEndIcon(
    {Widget? startIcon,
    VoidCallback? onPressedStartIcon,
    Widget? endIcon,
    VoidCallback? onPressedEndIcon,
    required String? text}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      startIcon != null
          ? GestureDetector(
              onTap: onPressedStartIcon,
              child: startIcon,
            )
          : const SizedBox.shrink(),
      sizeHor(6.w),
      appTextWidget(text: text, fontSize: 16.sp, fontWeight: FontWeight.w500),
      sizeHor(5.w),
      endIcon != null
          ? GestureDetector(
              onTap: onPressedEndIcon,
              child: endIcon,
            )
          : const SizedBox.shrink()
    ],
  );
}

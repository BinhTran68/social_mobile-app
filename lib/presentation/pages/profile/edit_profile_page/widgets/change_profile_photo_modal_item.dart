import 'package:flutter/material.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget changeProfileModalItem(
    {required String name,
    required VoidCallback onPressed,
    bool isFirstItem = false}) {
  return InkWell(
    borderRadius: isFirstItem
        ? const BorderRadius.only(
            topRight: Radius.circular(22), topLeft: Radius.circular(22))
        : BorderRadius.zero,
    onTap: () {
      onPressed();
    },
    child: SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Center(
          child: appTextWidget(
              text: name, fontSize: 16.sp, fontWeight: FontWeight.normal)),
    ),
  );
}

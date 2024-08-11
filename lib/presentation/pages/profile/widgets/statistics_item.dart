import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget statisticsItem({required dynamic statistic, required String type}) {
  return Column(
    children: [
      appTextWidget(text: statistic, fontSize: 16.sp),
      appTextWidget(text: type, fontSize: 13.sp, fontWeight: FontWeight.normal)
    ],
  );
}

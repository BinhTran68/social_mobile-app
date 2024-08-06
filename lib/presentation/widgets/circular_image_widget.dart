import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget circularImageWidget({required String url, required String name}) {
  return SizedBox(
    width: 65.w,
    height: 82.h,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center, //
          children: [
            Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFFBAA47),
                        Color(0xFFD91A46),
                        Color(0xFFA60F93),
                      ],
                    ))),
            Container(
              alignment: Alignment.center,
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipOval(
                child: Image.network(
                    width: 59, height: 59, fit: BoxFit.cover, url),
              ),
            ),
          ],
        ),
        sizeVer(5.h),
        appTextWidget(
            text: name, fontSize: 12.sp, fontWeight: FontWeight.normal)
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget circularImageWidget(
    {required String url,
    String? name,
    double widthCircular = 62,
    double heightCircular = 62}) {
  return SizedBox(
    width: name != null ? 65.w : widthCircular,
    height: name != null ? 82.h : heightCircular,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center, //
          children: [
            Container(
                width: widthCircular,
                height: heightCircular,
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
              width: widthCircular * 0.95,
              height: heightCircular * 0.95,
              decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipOval(
                child: Image.network(
                    width: widthCircular * 0.95,
                    height: widthCircular * 0.95,
                    fit: BoxFit.cover,
                    url),
              ),
            ),
          ],
        ),
        name != null ? sizeVer(5.h) : const SizedBox.shrink(),
        name != null
            ? appTextWidget(
                text: name, fontSize: 12.sp, fontWeight: FontWeight.normal)
            : SizedBox.shrink()
      ],
    ),
  );
}

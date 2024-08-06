import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';

Widget appIconWidget({ThemeData? theme}) {
  return SizedBox(
    width: 105.w,
    height: 28.h,
    child: SvgPicture.asset("assets/ic_instagram.svg",
        color: theme != null ? theme.primaryColorLight : Colors.white),
  );
}
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';


AppBar appBarEditProfilePage(BuildContext context) {
  final theme = ThemeManager().themeData;
  return AppBar(
    leadingWidth: 72.w,
    leading:   SizedBox(
      height: 21,
      child: Center(
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: appTextWidget(text: "Cancel",
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: theme?.hintColor
          ),
        ),
      ),
    ),
    title: Center(
      child: appTextWidget(
          fontSize: 16.sp,
          text: "Edit Profile"
      ),
    ),
    actions: [
      Center(
        child: Container(
          padding: EdgeInsets.only(right: 13.w),
          child: appTextWidget(text: "Done",
              fontSize: 16,
              color: ThemeState.secondPrimaryColor),
        ),
      )
    ],
  );
}
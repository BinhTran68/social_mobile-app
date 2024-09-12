import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';


AppBar newPostAppBar(BuildContext context, {
  required VoidCallback handleOnNext,
  String? title,
  bool isDisable = false
}) {
  final theme = ThemeManager().themeData;
  return AppBar(
    centerTitle: true,
    leading:   SizedBox(
      height: 21,
      child: Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.navigate_before_rounded, size: 35,),
        ),
      ),
    ),
    title: appTextWidget(
        fontSize: 16.sp,
        text: title ?? "New Post"
    ),
    actions: [
      Center(
        child: GestureDetector(
          onTap: isDisable ? (){} : handleOnNext,
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 15),
            width: 50.w,
            child: appTextWidget(text: "Next",
                fontSize: textFontSize.sp,
                color: ThemeState.secondPrimaryColor.withOpacity(isDisable ? 0.3 : 1)
            ),
          ),
        ),
      )
    ],
  );
}
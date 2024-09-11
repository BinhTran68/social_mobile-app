import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget detailInfoItemWidget(
    {required String? value,
    required String fieldName,
    required VoidCallback handleOnTap,
    bool isNavigator = false,
    }) {
  final theme = ThemeManager().themeData;
  return InkWell(
    onTap: handleOnTap,
    child: SizedBox(
      width: double.infinity,
      height: 48.h,
      child:  Padding(
        padding:  const EdgeInsets.only(left: paddingHor),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: appTextWidget(text: fieldName),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    height: double.maxFinite,
                    margin: EdgeInsets.only(right: 15.w),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(

                        border: Border(
                            bottom: BorderSide(
                                width: 0.8, color: secondaryColor.withOpacity(0.6)))),
                    child: appTextWidget(
                        text: value ?? fieldName,
                        color: value != null
                            ? theme?.hintColor
                            : secondaryColor.withOpacity(0.5)),
                  ),
                  isNavigator ?  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: paddingHor),
                        child: Icon(Icons.navigate_next_sharp),
                      )) : const SizedBox.shrink()
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

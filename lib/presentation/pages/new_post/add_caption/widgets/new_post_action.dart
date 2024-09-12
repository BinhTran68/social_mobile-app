import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

Widget newPostAction ({
  bool isFirstItem = false,
  bool isLastItem = false,
}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 55.h,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.6),
          bottom: BorderSide(color: Colors.grey, width: 0.6)
        ),

      ),
      child: Row(
        children: [
          const Icon(Icons.access_time_filled, size: 28,),
          sizeHor(20),
          appTextWidget(text: "Tag people"),
          const Spacer(),
          const Icon(Icons.navigate_next, size: 28,),


        ],
      ),

    );
}
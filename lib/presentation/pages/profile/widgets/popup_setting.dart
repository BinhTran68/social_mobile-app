import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/main.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final theme = ThemeBloc().currentTheme.themeData;

List<Widget> listMenuPopup(BuildContext context) => [
      _buildMenuPopupItem(
          icon: Icon(
            Icons.person_pin,
            color: theme.hintColor,
          ),
          label: "Profile",
          onPressed: () {}),
      _buildMenuPopupItem(
          icon: Icon(
            Icons.settings,
            color: theme.hintColor,
          ),
          label: "Settings",
          onPressed: () {}),
      _buildMenuPopupItem(
          icon: Icon(
            Icons.logout,
            color: theme.hintColor,
          ),
          label: "Logout",
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).loggedOut();
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, (route) => false);
          }),
    ];

Widget settingPopup({required BuildContext context}) {
  return Container(
    height: 550.h,
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: 32,
            height: 2,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          ),
          sizeVer(15),
          Column(
            children: listMenuPopup(context),
          )
        ],
      ),
    ),
  );
}

Widget _buildMenuPopupItem(
    {required dynamic icon,
    required String label,
    required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h)),
    onPressed: onPressed,
    child: Row(
      children: [
        icon,
        sizeHor(15.w),
        appTextWidget(
          text: label,
          color: theme.hintColor,
        )
      ],
    ),
  );
}

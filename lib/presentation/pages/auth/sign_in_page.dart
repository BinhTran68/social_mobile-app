import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            Center(
                child: SvgPicture.asset(
              "assets/ic_instagram.svg",
              color: primaryColor,
            )),
            sizeVer(39.h),
            const FormContainerWidget(
              hintText: "Email",
            ),
            sizeVer(12.h),
            const FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            sizeVer(33.h),
            Align(
                alignment: Alignment.centerRight,
                child: appTextWidget(
                    text: "Forgot Password",
                    color: theme.primaryColor.withAlpha(200))),
            sizeVer(30.h),
            ButtonContainerWidget(
              text: "Sign in",
              onTapListener: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      uid: '12323',
                    ),
                  ),
                );
              },
            ),
            // ButtonContainerWidget(
            //   text: "Change Theme",
            //   onTapListener: () {
            //     themeBloc.add(ThemeEvent.toggleLight);
            //   },
            // ),
            Flexible(flex: 2, child: Container()),
            const Divider(
              color: secondaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appTextWidget(
                    fontWeight: FontWeight.w400,
                    text: "Don't have an account? "),
                InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, PageConst.signInPage, (route) => false);
                    },
                    child: appTextWidget(
                        fontWeight: FontWeight.w600, text: "Sign Up? ")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

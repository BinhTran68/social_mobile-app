import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            Center(
                child: SvgPicture.asset(
              "assets/ic_instagram.svg",
              color: primaryColor,
            )),
            sizeVer(30),
            const FormContainerWidget(
              hintText: "Username",
            ),
            sizeVer(30),
            const FormContainerWidget(
              hintText: "Email",
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: "Password",
              isPasswordField: true,
            ),
            sizeVer(30),
            const FormContainerWidget(
              hintText: "Bio",
              isPasswordField: true,
            ),
            sizeVer(15),
            ButtonContainerWidget(
              text: "Sign in",
              onTapListener: () {},
            ),
            Flexible(flex: 2, child: Container()),
            const Divider(
              color: secondaryColor,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appTextWidget(
                    fontWeight: FontWeight.w400,
                    text: "Already have an account? "),
                InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, PageConst.signUpPage, (route) => false);
                    },
                    child: appTextWidget(
                        fontWeight: FontWeight.w600, text: "Sign In.")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

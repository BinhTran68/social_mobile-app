import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/app/enums/status.dart';

import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_app/presentation/pages/home/home_page.dart';
import 'package:instagram_app/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/progress_indicator_widget.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          } else if (state is CredentialFailure) {
            handleOnLoginFailure(context: context, status: state.status);
          }
        },
        builder: (context, state) {
          if (state is CredentialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return MainScreen(uid: state.uid);
                } else {
                  return _buildSignInForm(context, theme);
                }
              },
            );
          }
          return _buildSignInForm(context, theme);
        },
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(fit: FlexFit.loose, flex: 2, child: Container()),
          Center(
            child: SvgPicture.asset(
              "assets/ic_instagram.svg",
              color: primaryColor,
            ),
          ),
          sizeVer(39.h),
          FormContainerWidget(
            hintText: "Email",
            textEditingController: _emailController,
          ),
          sizeVer(12.h),
          FormContainerWidget(
            hintText: "Password",
            isPasswordField: true,
            textEditingController: _passwordController,
          ),
          sizeVer(33.h),
          Align(
            alignment: Alignment.centerRight,
            child: appTextWidget(
              text: "Forgot Password",
              color: theme.primaryColor.withAlpha(200),
            ),
          ),
          sizeVer(30.h),
          ButtonContainerWidget(
            text: "Sign in",
            onTapListener: () {
              handleOnSignIn(context);
            },
          ),
          sizeVer(15.h),
          const Divider(color: secondaryColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appTextWidget(fontWeight: FontWeight.w400, text: "Don't have an account? "),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
                },
                child: appTextWidget(fontWeight: FontWeight.w600, text: "Sign Up? "),
              ),
            ],
          ),
          Flexible(flex: 2, fit: FlexFit.loose, child: Container()),
        ],
      ),
    );
  }

  void handleOnSignIn(BuildContext context) {
    BlocProvider.of<CredentialCubit>(context).signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void handleOnLoginFailure({required BuildContext context, Status? status}) {
    toast(status.toString());
  }
}


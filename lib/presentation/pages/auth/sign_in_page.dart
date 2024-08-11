import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_app/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/progress_indicator_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSign = false;
  late ThemeData theme;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
     theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme?.backgroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        // Lắng nghe các state từ CredentialState gửi sang
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (state is CredentialFailure) {
            toast("Email and password invalid");
          }
        },
        // Lắng nghe các sự kiện
        builder: (context, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return MainScreen(uid: state.uid);
                }else {
                    return _bodyWidget(themeBloc);
                }
              },
            );
          }
          return _bodyWidget(themeBloc);
        },
      ),
    );
  }

  Widget _bodyWidget(ThemeBloc themeBloc,) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                fit: FlexFit.loose,
                flex: 2, child: Container()),
            Center(
                child: SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  color: primaryColor,
                )),
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
                    color: theme?.primaryColor.withAlpha(200))),
            sizeVer(30.h),
            ButtonContainerWidget(
              text: "Sign in",
              onTapListener: () {
                handleOnSignIn();
              },
            ),
            sizeVer(15.h),
            _isSign ? const ProgressIndicatorWidget() : SizedBox.shrink(),
            Flexible(flex: 2,
                fit: FlexFit.loose,child: Container()),
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
                          context, PageConst.signUpPage, (route) => false);
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

  void handleOnSignIn() {
    setState(() {
      _isSign = true;
    });
    BlocProvider.of<CredentialCubit>(context).signInUser(
        email: _emailController.text, password: _passwordController.text).then((
        value) => _clear());
  }

  void _clear() {
    _isSign = false;
    _emailController.clear();
    _passwordController.clear();
  }
}

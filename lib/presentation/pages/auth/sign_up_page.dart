import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_app/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:instagram_app/presentation/widgets/progress_indicator_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isSigningUp = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            // Nếu tạo tài khoản thành công thì gọi đến hàm loggedIn
            if (credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            // Nếu trạng thai trả về là fail thì toast ra cho người dùng
            if (credentialState is CredentialFailure) {
              toast("Invalid Email and Password");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else {
                  return _bodySignUpWidget();
                }
              });
            }
            return _bodySignUpWidget();
          },
        ));
  }

  Widget _bodySignUpWidget() {
    return Padding(
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
          sizeVer(15),
          FormContainerWidget(
            hintText: "Username",
            textEditingController: _usernameController,
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Email",
            textEditingController: _emailController,
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Password",
            isPasswordField: true,
            textEditingController: _passwordController,
          ),
          sizeVer(15),
          FormContainerWidget(
            hintText: "Bio",
            textEditingController: _bioController,
            isPasswordField: true,
          ),
          sizeVer(30),
          ButtonContainerWidget(
            text: "Sign Up",
            onTapListener: () {
              _signUpUser();
            },
          ),
          sizeVer(10),
          (_isSigningUp || _isUploading)
              ? const ProgressIndicatorWidget()
              : const SizedBox.shrink(),
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
                        context, PageConst.signInPage, (route) => false);
                  },
                  child: appTextWidget(
                      fontWeight: FontWeight.w600, text: "Sign In.")),
            ],
          )
        ],
      ),
    );
  }

  void _signUpUser() {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
            user: UserEntity(
                email: _emailController.text,
                username: _usernameController.text,
                bio: _bioController.text,
                password: _passwordController.text,
                followers: [],
                following: [],
                uid: '',
                totalPosts: 0,
                totalFollowers: 0,
                totalFollowing: 0))
        .then((value) => _clear());
  }

  void _clear() {
    setState(() {
      _usernameController.clear();
      _bioController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }
}

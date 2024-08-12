import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/pages/auth/sign_in_page.dart';
import 'package:instagram_app/presentation/pages/auth/sign_up_page.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/edit_profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.signUpPage:
        {
          return routeBuilder(const SignUpPage());
        }
      case PageConst.signInPage:
        {
          return routeBuilder(const SignInPage());
        }
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return routeBuilder(EditProfilePage(userEntity: args));
          }
          return routeBuilder(const NoPageFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/on_generate_route.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_app/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_app/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_app/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_app/presentation/pages/auth/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/presentation/pages/main_screen/main_screen.dart';
import 'injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static late ThemeData theme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<PostCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        // BlocProvider(create: (_) => di.sl<GetSingleOtherUserCubit>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                theme: state.themeData,
                debugShowCheckedModeBanner: false,
                title: "Instagram Clone",
                onGenerateRoute: OnGenerateRoute.route,
                initialRoute: "/",
                routes: {
                  "/": (context) {
                    return BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, authSate) {
                        if (authSate is Authenticated) {
                          return MainScreen(uid: authSate.uid);
                        } else {
                          return  SignInPage();
                        }
                      },
                    );
                  }
                },
              );
            });
      }),
    );
  }
}

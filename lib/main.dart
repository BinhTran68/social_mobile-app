import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_bloc.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/on_generate_route.dart';
import 'package:instagram_app/presentation/pages/auth/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc())
        // BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        // BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        // BlocProvider(create: (_) => di.sl<UserCubit>()),
        // BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
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
                home: const SignInPage(),
                // initialRoute: "/",
                // routes: {
                //   "/": (context) {
                //     return BlocBuilder<AuthCubit, AuthState>(
                //       builder: (context, authState) {
                //         if (authState is Authenticated) {
                //           return MainScreen(uid: authState.uid,);
                //         } else {
                //           return SignInPage();
                //         }
                //       },
                //     );
                //   }
                // },
              );
            });
      }),
    );
  }
}

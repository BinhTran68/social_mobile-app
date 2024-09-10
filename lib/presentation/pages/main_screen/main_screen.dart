import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_app/presentation/pages/home/home_page.dart';
import 'package:instagram_app/presentation/pages/profile/profile_page.dart';
import 'package:instagram_app/presentation/pages/search/search_page.dart';
import 'package:instagram_app/presentation/widgets/progress_indicator_widget.dart';

class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {

    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        // Nếu trạng thái trả về là GetSingleUserLoaded
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            backgroundColor: theme.backgroundColor,
            bottomNavigationBar: CupertinoTabBar(
              height: 79.h,
              backgroundColor: theme.backgroundColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: theme.primaryColorLight),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search, color: theme.primaryColorLight),
                    label: ""),
                BottomNavigationBarItem(
                    icon:
                        Icon(Icons.add_circle, color: theme.primaryColorLight),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite, color: theme.primaryColorLight),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined,
                        color: theme.primaryColorLight),
                    label: ""),
              ],
              onTap: navigationTapped,
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                HomePage(),
                SearchPage(),
                Container(color: Colors.red),
                Container(color: Colors.black),
                ProfilePage(user: currentUser)
              ],
            ),
          );
        }
        return Container(
          width: 100,
          height: 100,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Colors.blue, Colors.red],
                tileMode: TileMode.repeated,
              ).createShader(bounds);
            },
            child: const CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
            ),
          ),
        );
      },
    );
  }
}

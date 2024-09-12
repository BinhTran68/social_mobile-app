import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/pages/profile/widgets/popup_setting.dart';
import 'package:instagram_app/presentation/pages/profile/widgets/statistics_item.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/button_container_widget.dart';
import 'package:instagram_app/presentation/widgets/circular_image_widget.dart';
import 'package:instagram_app/presentation/widgets/icon_widget/menu_icon_widget.dart';
import 'package:instagram_app/presentation/widgets/popup_bottom.dart';
import 'package:instagram_app/presentation/widgets/title_and_start_or_end_icon.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;

  ProfilePage({super.key, required this.user});

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        title: titleAndStartOrEndIcon(
          text: user.username,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: menuIconWidget(onPressed: () {
              popupBottom(
                  context: context, child: settingPopup(context: context));
            }),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 315.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatarAndStatisticsProfile(user : user),
                  sizeVer(12.h),
                  _buildNameAndBioInfo(
                      name: user.name ?? user.email!,
                      bio: user.bio),
                  sizeVer(15.h),
                  ButtonContainerWidget(
                    height: 29.h,
                    color: Colors.black,
                    text: "Edit profile",
                    isHasBorder: true,
                    onTapListener: () {
                      Navigator.pushNamed(context, PageConst.editProfilePage,
                          arguments: user);
                    },
                  ),
                  sizeVer(16.h),
                  Row(
                    children: [
                      circularImageWidget(
                          url:
                              "https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/04/anh-avatar-dep-cho-con-gai-ngau.jpg",
                          name: "New"),
                      circularImageWidget(
                          url:
                              "https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/04/anh-avatar-dep-cho-con-gai-ngau.jpg",
                          name: "New"),
                      circularImageWidget(
                          url:
                              "https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/04/anh-avatar-dep-cho-con-gai-ngau.jpg",
                          name: "New"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.cloud_outlined),
                      ),
                      Tab(
                        icon: Icon(Icons.beach_access_sharp),
                      ),
                      Tab(
                        icon: Icon(Icons.brightness_5_sharp),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Expanded(child: Container(
                          height: 200,
                          color: Colors.red,
                        ))
                        ,
                        Center(
                          child: Text("It's rainy here"),
                        ),
                        Center(
                          child: Text("It's sunny here"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

Widget _buildNameAndBioInfo({required String name, String? bio}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appTextWidget(text: name),
      appTextWidget(text: bio ?? "", fontWeight: FontWeight.normal),
    ],
  );
}

Widget _buildAvatarAndStatisticsProfile({required UserEntity user}) {
  return Row(
    children: [
      circularImageWidget(
          widthCircular: 96,
          heightCircular: 96,
          url: user.profileUrl ?? ""
      ),
      sizeHor(35.w),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            statisticsItem(statistic: user.totalPosts?.toString() , type: "posts"),
            statisticsItem(statistic: user.followers?.length.toString(), type: "flowers"),
            statisticsItem(statistic: user.following?.length.toString(), type: "flowing"),
          ],
        ),
      )
    ],
  );
}

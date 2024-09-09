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

class ProfilePage extends StatefulWidget {
  final UserEntity user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _ProfilePageState extends State<ProfilePage> {
  SampleItem? selectedMenu;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    print("current user ${widget.user}");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        title: titleAndStartOrEndIcon(
          text: widget.user.username,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatarAndStatisticsProfile(),
                  sizeVer(12.h),
                  _buildNameAndBioInfo(
                      name: widget.user.name ?? widget.user.email!,
                      bio: widget.user.bio),
                  sizeVer(15.h),
                  ButtonContainerWidget(
                    height: 29.h,
                    color: Colors.black,
                    text: "Edit profile",
                    isHasBorder: true,
                    onTapListener: () {
                      Navigator.pushNamed(context, PageConst.editProfilePage,
                          arguments: widget.user);
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
                  ),
                  sizeVer(15.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

Widget _buildAvatarAndStatisticsProfile() {
  return Row(
    children: [
      circularImageWidget(
          widthCircular: 96,
          heightCircular: 96,
          url:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxXp5DUBVtnfBxsd8hNqBgbrl23RM7zxLElw&s"),
      sizeHor(35.w),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            statisticsItem(statistic: "560", type: "Posts"),
            statisticsItem(statistic: "560", type: "Posts"),
            statisticsItem(statistic: "560", type: "Posts"),
          ],
        ),
      )
    ],
  );
}

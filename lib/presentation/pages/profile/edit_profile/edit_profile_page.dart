import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/widgets/app_bar.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/widgets/change_profile_photo_modal.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/circular_image_widget.dart';
import 'package:instagram_app/presentation/widgets/detailInfoItemWidget.dart';
import 'package:instagram_app/presentation/widgets/popup_bottom.dart';

// Có nên truyền vào đây argrument
class EditProfilePage extends StatefulWidget {
  final UserEntity userEntity;

  const EditProfilePage({super.key, required this.userEntity});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final theme = ThemeManager().themeData;
  late String imagePath;
  String currentImagePath =
      "https://ik.imagekit.io/tvlk/blog/2021/09/du-lich-anh-2.jpg?tr=dpr-2,w-675";
  bool isPreview = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> userProfileInfoList() => [
          detailInfoItemWidget(
              value: widget.userEntity.name,
              fieldName: "Name",
              handleOnTap: () {}),
          detailInfoItemWidget(
              value: widget.userEntity.username,
              fieldName: "UserName",
              handleOnTap: () {}),
        ];

    return Scaffold(
      appBar: appBarEditProfilePage(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160.h,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 18.5),
                      child: circularImageWidget(
                          heightCircular: 95.h,
                          widthCircular: 95.w,
                          isShowBorder: false,
                          url: currentImagePath,
                          isPreviewImage: isPreview),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popupBottom(
                          context: context,
                          child: ChangeProfilePhotoModal(
                            onDataChanged: (data) {
                              Navigator.pop(context);
                              setState(() {
                                currentImagePath = data;
                                isPreview = true;
                              });
                            },
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                          vertical: 13.h, horizontal: 12.w),
                      child: appTextWidget(
                          text: "Change Profile Photo",
                          color: ThemeState.secondPrimaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: secondaryColor.withOpacity(0.5),
            ),
            Column(
              children: userProfileInfoList(),
            )
          ],
        ),
      ),
    );
  }
}

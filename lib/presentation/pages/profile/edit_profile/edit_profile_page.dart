import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/widgets/app_bar.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/widgets/change_profile_photo_modal.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
import 'package:instagram_app/presentation/widgets/circular_image_widget.dart';
import 'package:instagram_app/presentation/widgets/detailInfoItemWidget.dart';
import 'package:instagram_app/presentation/widgets/icon_widget/overlay_loading.dart';
import 'package:instagram_app/presentation/widgets/popup_bottom.dart';



class EditProfilePage extends StatelessWidget {
  final UserEntity userEntity;
  const EditProfilePage({super.key, required this.userEntity});
  
  @override
  Widget build(BuildContext context) {
     String? currentImagePath = userEntity.profileUrl;
     bool? isPreview = false;

    List<Widget> userProfileInfoList() => [
      detailInfoItemWidget(
          value: userEntity.name,
          fieldName: "Name",
          handleOnTap: () {}),
      detailInfoItemWidget(
          value: userEntity.username,
          fieldName: "UserName",
          handleOnTap: () {}),
      detailInfoItemWidget(
          value: userEntity.email,
          fieldName: "Email",
          handleOnTap: () {}),
      detailInfoItemWidget(
          value: userEntity.bio,
          fieldName: "Bio",
          handleOnTap: () {}),
    ];

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, userState) {
        if (userState is UserSuccess) {
          Navigator.pop(context);
        }
        if(userState is UserFailure) {
          toast("");
        }

      },
      builder: (context, userState) {
        final avatarFile = (userState is UserLoaded)
            ? userState.avatarFile
            : null;

        if(userState is UserLoaded) {
            if(userState.currentImagePath != null) {
              currentImagePath = userState.currentImagePath;
              isPreview = userState.isPreview;
            }
        }
        
        final blocAction = BlocProvider.of<UserCubit>(context);

        return Stack(
          children: [
            Scaffold(
              appBar: appBarEditProfilePage(context, handleOnSave: () {
                if (avatarFile != null) {
                  blocAction.updateUserAvatar(file: avatarFile, uid: userEntity.uid!);
                } else {
                  Navigator.pop(context);
                }
              }),
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
                                  url: currentImagePath ?? "",
                                  isPreviewImage: isPreview ?? false),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              popupBottom(
                                  context: context,
                                  child: ChangeProfilePhotoModal(
                                    onDataChanged: (data) {
                                      Navigator.pop(context);
                                      blocAction.onImageSelected(data);
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
                    ),
                  ],
                ),
              ),
            ),
            (userState is UserLoading)
                ? const OverlayLoading()
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}


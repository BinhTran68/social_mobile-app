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
import 'package:instagram_app/presentation/pages/profile/edit_profile_page/widgets/app_bar.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile_page/widgets/change_profile_photo_modal.dart';
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


    return BlocConsumer<UserCubit, UserState>(
      listener: (context, userState) {
        if (userState is UserSuccess) {
          Navigator.pop(context);
        }
        if (userState is UserFailure) {
            toast(userState.message.toString());
        }
        if(userState is UserPopContext) {
          Navigator.pop(context);
        }
      },
      builder: (context, userState) {
        UserEntity currentUser = userEntity;
        final avatarFile =
            (userState is UserLoaded) ? userState.avatarFile : null;

        if (userState is UserLoaded) {
          if (userState.currentImagePath != null) {
            currentImagePath = userState.currentImagePath;
            isPreview = userState.isPreview;
          }
          if(userState.users.isNotEmpty) {
            currentUser = userState.users.first;
          }
        }

        
        final blocAction = BlocProvider.of<UserCubit>(context);
        List<Widget> userProfileInfoList() {
          return [
            detailInfoItemWidget(
                value: currentUser.name,
                fieldName: "Name",
                handleOnTap: () {
                  handleRouteToEdit(
                      context: context,
                      fieldTitle: "Name",
                      value: currentUser.name ?? "",
                      currentUser: currentUser);
                }),
            detailInfoItemWidget(
                value: currentUser.username,
                fieldName: "Username",
                handleOnTap: () {
                  handleRouteToEdit(
                      context: context,
                      fieldTitle: "Username",
                      value: currentUser.username ?? "",
                      currentUser: currentUser);
                }),
            detailInfoItemWidget(
                value: userEntity.email,
                fieldName: "Email",
                handleOnTap: () {
                  handleRouteToEdit(
                      context: context,
                      fieldTitle: "Email",
                      value: currentUser.email ?? "", currentUser: currentUser);
                }),
            detailInfoItemWidget(
                value: currentUser.bio,
                fieldName: "Bio",
                handleOnTap: () {
                  handleRouteToEdit(
                      context: context,
                      fieldTitle: "Bio",
                      value: currentUser.bio ?? "", currentUser: currentUser);
                }),
            // detailInfoItemWidget(
            //     value: currentUser.bio,
            //     fieldName: "Links",
            //     handleOnTap: () {}),
            detailInfoItemWidget(
                value: currentUser.bio,
                isNavigator: true,
                fieldName: "Gender",
                handleOnTap: () {}),
          ];
        }

        return Stack(
          children: [
            Scaffold(
              appBar: appBarEditProfilePage(context, handleOnSave: () {
                if (avatarFile != null) {
                  blocAction.updateUserAvatar(
                      file: avatarFile, uid: currentUser.uid!);
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

  void handleRouteToEdit(
      {required BuildContext context,
      required String fieldTitle,
      required String value,
      String? titleNote, 
      required UserEntity currentUser
      }) {
    Map<String, dynamic> mapArguments = {
      "userEntity": currentUser,
      "fieldTitle": fieldTitle,
      "value": value,
      "titleNote": titleNote,
    };
    Navigator.pushNamed(context, PageConst.updateFieldUserInfo,
        arguments: mapArguments);
  }
}

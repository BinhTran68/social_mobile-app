
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:instagram_app/consts.dart';
  import 'package:instagram_app/domain/entities/user/user_entity.dart';
  import 'package:instagram_app/presentation/cubit/user/user_cubit.dart';
  import 'package:instagram_app/presentation/pages/profile/edit_profile_page/widgets/app_bar.dart';
  import 'package:instagram_app/presentation/widgets/app_text_widget.dart';
  import 'package:instagram_app/presentation/widgets/form_container_widget.dart';
import 'package:instagram_app/presentation/widgets/icon_widget/overlay_loading.dart';
  import 'package:instagram_app/presentation/widgets/text_form_with_sunffix_action_widget.dart';
  import 'package:flutter/cupertino.dart';

  class EditUserInfoField extends StatelessWidget {
    final String fieldTitle;
    final String value;
    final String? titleNote;
    final UserEntity userEntity;
    final String? firstNote;
    final String? secondNote;

    const EditUserInfoField({
      super.key,
      required this.fieldTitle,
      required this.value,
      required this.titleNote,
      required this.userEntity,
       this.firstNote,
       this.secondNote,
    });

    @override
    Widget build(BuildContext context) {

      TextEditingController editFieldController = TextEditingController();

      editFieldController.text = value;
      String beforeChangeValue = value;

      return BlocConsumer<UserCubit, UserState>(
        listener: (context, userState) {

          print(userState);
        },
        builder: (context, userState) {
          final blocActions = BlocProvider.of<UserCubit>(context);
          return Stack(
            children: [
                Scaffold(
                  appBar: appBarEditProfilePage(context, handleOnSave: () {
                    if(editFieldController.text != beforeChangeValue) {
                      UserEntity userUpdate = UserEntity(uid: userEntity.uid);
                      String valueUpdate = editFieldController.text;
                      switch (fieldTitle) {
                        case  "Name" : {
                          userUpdate = userUpdate.copyWith(name: valueUpdate);
                          break;
                        }
                        case  "Email" : {
                          userUpdate = userUpdate.copyWith(email: valueUpdate);
                          break;
                        }
                        case  "Username" : {
                          userUpdate = userUpdate.copyWith(username: valueUpdate);
                          break;
                        }
                        case  "Bio" : {
                          userUpdate = userUpdate.copyWith(bio: valueUpdate);
                          break;
                        }
                      }
                      blocActions.updateUser(user: userUpdate);
                    }else {
                      Navigator.pop(context);
                    }
                  }, title: fieldTitle),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: paddingHor, vertical: paddingVer),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          TextFormWithSuffixActionWidget(
                            hintText: fieldTitle,
                           textEditingController: editFieldController,
                           handleOnTapSuffixIcon: () {
                             editFieldController.text = "";
                           },
                           borderRadius: 12,
                           suffixIcon: const Icon(CupertinoIcons.xmark_circle),
                                              ),
                          sizeVer(15.h),
                          appTextWidget(
                              color: fadedText,
                              text: titleNote ?? ""),
                        sizeVer(10.h),
                        appTextWidget(
                            color: fadedText,
                            text: titleNote ?? ""),

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

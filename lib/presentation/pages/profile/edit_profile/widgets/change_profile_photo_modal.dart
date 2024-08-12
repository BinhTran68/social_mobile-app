import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/presentation/pages/profile/edit_profile/widgets/change_profile_photo_modal_item.dart';
import 'package:instagram_app/presentation/widgets/app_text_widget.dart';

class ChangeProfilePhotoModal extends StatefulWidget {
  const ChangeProfilePhotoModal({super.key, required this.onDataChanged});
  final Function(String) onDataChanged; // call back ra widget cha 1 function

  @override
  State<ChangeProfilePhotoModal> createState() =>
      _ChangeProfilePhotoModalState();
}

class _ChangeProfilePhotoModalState extends State<ChangeProfilePhotoModal> {
  bool _isUpdating = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.onDataChanged(_image!.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return changeProfilePhotoModal(context);
  }

  Widget changeProfilePhotoModal(BuildContext context) {
    final theme = ThemeManager().themeData;
    List<Widget> listItemChangeProfilePhotoModal() => [
          changeProfileModalItem(
              name: "Choose from library",
              isFirstItem: true,
              onPressed: () {
                selectImage();
              }),
          changeProfileModalItem(name: "Take a Photo", onPressed: () {}),
          changeProfileModalItem(name: "Cancel", onPressed: () {}),
        ];

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 300.h,
      child: Container(
        color: theme?.backgroundColor,
        child: Column(
          children: listItemChangeProfilePhotoModal(),
        ),
      ),
    );
  }
}

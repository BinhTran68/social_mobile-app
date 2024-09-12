import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const backGroundColor = Color.fromRGBO(0, 0, 0, 1.0);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Colors.white;
const secondaryColor = Colors.grey;
const darkGreyColor =  Color.fromRGBO(97, 97, 97, 1);
Color fadedText = Colors.grey.withOpacity(0.6);


Widget sizeVer(double height) {
  return SizedBox(height: height,);
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}




// Space Config

const double paddingHor = 15;
const double paddingVer = 15;


// text

const textFontSize = 14;
const titleFontSize = 16;

// App Config

const String defaultAvatarConfig = "https://ik.imagekit.io/tvlk/blog/2021/09/du-lich-anh-2.jpg?tr=dpr-2,w-675";


class PageConst {
  static const String editProfilePage = "editProfilePage";
  static const String updatePostPage = "updatePostPage";
  static const String commentPage = "commentPage";
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String updateCommentPage = "updateCommentPage";
  static const String updateReplayPage = "updateReplayPage";
  static const String postDetailPage = "postDetailPage";
  static const String singleUserProfilePage = "singleUserProfilePage";
  static const String followingPage = "followingPage";
  static const String followersPage = "followersPage";
  static const String updateFieldUserInfo = "updateFieldUserInfo";
  static const String newPostPage = "newPostPage";
  static const String newPostAddCaptionPage = "newPostAddCaptionPage";


}

// giá trị collection ở firebase 
class FirebaseConst {
  static const String users = "users";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";

}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}











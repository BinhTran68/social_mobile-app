import 'dart:io';


import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/response/object_response.dart';

abstract class UserRemoteData {
  

  // auth
  Future<Status> signInUser(UserEntity user);
  Future<Status> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  // User
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> followUnFollowUser(UserEntity user);

  Future<ObjectResponse> updateUserAvatar(File file, String fileName, uid);

}
import 'dart:io';

import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/response/object_response.dart';

abstract class FirebaseRepository {
  // Khởi tạo
  Future<Status> signInUser(UserEntity user);

  Future<Status> signUpUser(UserEntity user);

  Future<bool> isSignIn();

  Future<void> signOut();

  // User
  // Lấy danh sách user được cập nhật mới liên tục
  Stream<List<UserEntity>> getUsers(UserEntity userEntity);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> followUnFollowUser(UserEntity user);

  Future<ObjectResponse> updateUserAvatar(File file, String fileName, uid);

}

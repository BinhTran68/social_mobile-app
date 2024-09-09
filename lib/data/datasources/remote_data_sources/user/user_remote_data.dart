import 'package:instagram_app/app/enums/auth_status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';

abstract class UserRemoteData {
  

  // auth
  Future<AuthStatus> signInUser(UserEntity user);
  Future<AuthStatus> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  // User
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> followUnFollowUser(UserEntity user);

}
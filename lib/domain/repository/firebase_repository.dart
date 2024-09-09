import 'package:instagram_app/app/enums/auth_status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  // Khởi tạo
  Future<AuthStatus> signInUser(UserEntity user);

  Future<AuthStatus> signUpUser(UserEntity user);

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

}

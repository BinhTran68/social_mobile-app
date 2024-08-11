import 'package:instagram_app/data/datasources/remote_data_sources/post/post_remote_data.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/user/user_remote_data.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/domain/repository/firebase_repository.dart';

// Tầng hiện thực các interface
class FirebaseRepositoryImpl implements FirebaseRepository {
  // Tiêm các phụ thuộc
  final UserRemoteData userRemoteData;
  final PostRemoteData postRemoteData;

  FirebaseRepositoryImpl(
      {required this.userRemoteData, required this.postRemoteData});

  @override
  Future<void> createUser(UserEntity user) async {
    return await userRemoteData.createUser(user);
  }

  @override
  Future<void> followUnFollowUser(UserEntity user) async {
    return await userRemoteData.followUnFollowUser(user);
  }

  @override
  Future<String> getCurrentUid() async {
    return await userRemoteData.getCurrentUid();
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    return userRemoteData.getSingleUser(uid);
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity userEntity) {
    return userRemoteData.getUsers(userEntity);
  }

  @override
  Future<bool> isSignIn() async {
    return await userRemoteData.isSignIn();
  }

  @override
  Future<void> signInUser(UserEntity user) async {
    return await userRemoteData.signInUser(user);
  }

  @override
  Future<void> signOut() async {
    return await userRemoteData.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    return await userRemoteData.signUpUser(user);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    return await userRemoteData.updateUser(user);
  }
}

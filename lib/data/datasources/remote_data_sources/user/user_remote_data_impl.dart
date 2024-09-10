import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/user/user_remote_data.dart';
import 'package:instagram_app/data/models/user_model.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_app/response/object_response.dart';

class UserRemoteDataImpl implements UserRemoteData {
  // Nơi triển khai cụ thể các phương thức đã thiết kế
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataImpl(
      {
        required this.firebaseStorage,
        required this.firebaseAuth,
        required this.firebaseFirestore});

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    String uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
              uid: uid,
              username: user.username,
              name: user.name,
              bio: user.bio,
              website: user.website,
              email: user.email,
              profileUrl: user.profileUrl,
              followers: user.followers,
              following: user.following,
              totalFollowers: user.totalFollowers,
              totalFollowing: user.totalFollowing,
              totalPosts: user.totalPosts)
          .toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      print(error);
      toast("Some error occur");
    });
  }

  @override
  Future<void> followUnFollowUser(UserEntity user) {
    // TODO: implement followUnFollowUser
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUid() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    final snapshot = userCollection
        .snapshots(); // tạo ra stream mà mỗi phần tử là 1 Querysnapshot
    return snapshot.map((querySnapShot) =>
        querySnapShot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final snapshot = userCollection.snapshots();
    return snapshot.map((querySnapShot) =>
        querySnapShot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async {
    return firebaseAuth.currentUser?.uid != null;
  }

  @override
  Future<Status> signInUser(UserEntity user) async {
    // return message to view handle ??
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
        return Status.success;
      } else {
        return Status.invalidEmailOrPassword;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Status.userNotFound;
      } else if (e.code == "wrong-password") {
        return Status.invalidEmailOrPassword;
      } else {
        return Status.invalidEmailOrPassword;
      }
    } catch (e) {
      return Status.invalidEmailOrPassword;
      // Record Log to server
    }
  }

  @override
  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  @override
  Future<Status> signUpUser(UserEntity user) async {
    try {

      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) {
        createUser(user);
      });
      return Status.success;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return Status.emailAlreadyExits;
      } else if (e.code == "invalid-email") {
        return Status.invalidEmail;
      } else if (e.code == "weak-password") {
       return Status.weakPassword;
      }else {
        return Status.error;
      }
    } catch (e) {
      return Status.error;
    }
  }

  // Hanle function update user. '

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = Map();

    if (user.username != "" && user.username != null) userInformation['username'] = user.username;

    if (user.website != "" && user.website != null) userInformation['website'] = user.website;

    if (user.profileUrl != "" && user.profileUrl != null) userInformation['profileUrl'] = user.profileUrl;

    if (user.bio != "" && user.bio != null) userInformation['bio'] = user.bio;

    if (user.name != "" && user.name != null) userInformation['name'] = user.name;

    if (user.totalFollowing != null) userInformation['totalFollowing'] = user.totalFollowing;

    if (user.totalFollowers != null) userInformation['totalFollowers'] = user.totalFollowers;

    if (user.totalPosts != null) userInformation['totalPosts'] = user.totalPosts;

    userCollection.doc(user.uid).update(userInformation);

  }

  @override
  Future<ObjectResponse> updateUserAvatar(File file, String fileName, uid) async {
    ObjectResponse objectResponse = ObjectResponse(status: Status.success);
    try {
      Reference ref = firebaseStorage.ref().child('images/$fileName');
      await ref.putFile(file);
      String url = await ref.getDownloadURL();
      // có được url thì update
      UserEntity userEntity = UserEntity(uid: uid,profileUrl: url);
      await updateUser(userEntity);


      objectResponse.data = url;
      return objectResponse;
    } catch (e) {
        objectResponse.status = Status.error;
        return objectResponse;
    }
  }
}

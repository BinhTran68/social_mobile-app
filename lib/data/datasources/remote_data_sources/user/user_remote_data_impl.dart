import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_app/consts.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/user/user_remote_data.dart';
import 'package:instagram_app/data/models/user_model.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';

class UserRemoteDataImpl implements UserRemoteData {
  // Nơi triển khai cụ thể các phương thức đã thiết kế
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserRemoteDataImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

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
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        print("Fields can't empty!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("user not found");
      } else if (e.code == "wrong-password") {
        toast("Invalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) {
        createUser(user);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
      }
    }
  }

  // Hanle function update user. '

  @override
  Future<void> updateUser(UserEntity user) async {
    print(" UserEntity $user");
    // final userCollection = firebaseFirestore.collection(FirebaseConst.users);
  }
}

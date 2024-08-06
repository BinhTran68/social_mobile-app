import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  UserModel({
    required this.uid,
    required this.username,
    required this.name,
    required this.bio,
    required this.website,
    required this.email,
    required this.profileUrl,
    required this.followers,
    required this.following,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.totalPosts,
  }) : super(
          uid: uid,
          totalFollowing: totalFollowing,
          followers: followers,
          totalFollowers: totalFollowers,
          username: username,
          profileUrl: profileUrl,
          website: website,
          following: following,
          bio: bio,
          name: name,
          email: email,
          totalPosts: totalPosts,
        );

  // factory là 1 contructor đặc biệt
  //factory  có thể trả về đối tượng tại ngữ cảnh hiện tại của lớp
  // Có thể xayy dựng logic khởi tạo
  // Dùng để nhận các đuối tượng từ firebase gửi xuống
  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid'],
        username: snapshot['username'],
        name: snapshot['name'],
        bio: snapshot['bio'],
        website: snapshot['website'],
        email: snapshot['email'],
        profileUrl: snapshot['profileUrl'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        totalFollowers: snapshot['totalFollowers'],
        totalFollowing: snapshot['totalFollowing'],
        totalPosts: snapshot['totalPosts']);
  }

// Convert Map to Json when save entity
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "totalFollowing": totalFollowing,
      "followers": followers,
      "totalFollowers": totalFollowers,
      "username": username,
      "profileUrl": profileUrl,
      "website": website,
      "following": following,
      "bio": bio,
      "name": name,
      "email": email,
      "totalPosts": totalPosts,
    };
  }
}

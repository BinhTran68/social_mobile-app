import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  final File? imageFile;
  final String? password;
  final String? otherUid;

  UserEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.password,
    this.otherUid,
    this.totalPosts,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        name,
        bio,
        website,
        email,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        password,
        otherUid,
        totalPosts,
        imageFile
      ];

  UserEntity copyWith({
    String? uid,
    String? username,
    String? name,
    String? bio,
    String? website,
    String? email,
    String? profileUrl,
    List? followers,
    List? following,
    num? totalFollowers,
    num? totalFollowing,
    num? totalPosts,
    File? imageFile,
    String? password,
    String? otherUid,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      website: website ?? this.website,
      email: email ?? this.email,
      profileUrl: profileUrl ?? this.profileUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      totalPosts: totalPosts ?? this.totalPosts,
      imageFile: imageFile ?? this.imageFile,
      password: password ?? this.password,
      otherUid: otherUid ?? this.otherUid,
    );
  }


}

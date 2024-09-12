import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final List<String>? postImageUrls;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  const PostEntity({
    this.postId,
    this.creatorUid,
    this.username,
    this.description,
    this.postImageUrls,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    postId,
    creatorUid,
    username,
    description,
    postImageUrls,
    likes,
    totalLikes,
    totalComments,
    createAt,
    userProfileUrl,
  ];
}

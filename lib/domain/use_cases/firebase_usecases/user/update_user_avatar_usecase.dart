import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/app/helpers.dart';
import 'package:instagram_app/domain/repository/firebase_repository.dart';
import 'package:instagram_app/response/object_response.dart';

class UpdateUserAvatarUseCase {
  FirebaseRepository firebaseRepository;

  UpdateUserAvatarUseCase({required this.firebaseRepository});

  Future<ObjectResponse> call(File file, uid) async {
    final fileName = "avatar+${Helpers.getFormattedDateTime()}";
    return firebaseRepository.updateUserAvatar(file, fileName, uid);
  }
}

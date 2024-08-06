

import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/domain/repository/firebase_repository.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}
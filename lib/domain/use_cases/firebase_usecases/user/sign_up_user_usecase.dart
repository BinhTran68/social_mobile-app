import 'package:instagram_app/domain/entities/user/user_entity.dart';

import '../../../repository/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    print("SignUpUseCase");
    return repository.signUpUser(userEntity);
  }
}

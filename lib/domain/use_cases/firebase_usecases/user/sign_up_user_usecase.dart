import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';

import '../../../repository/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});
  Future<Status> call(UserEntity userEntity) {
    return repository.signUpUser(userEntity);
  }
}

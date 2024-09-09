import 'package:instagram_app/app/enums/user_actions_status.dart';
import 'package:instagram_app/domain/repository/firebase_repository.dart';

class SaveUserAvatarUseCase {
  FirebaseRepository firebaseRepository;

  SaveUserAvatarUseCase({required this.firebaseRepository});

  Future<UserActionStatus> call() async {
      return UserActionStatus.success;
  }


}

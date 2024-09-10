import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_app/app/enums/status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/follow_unfollow_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/get_users_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/update_user_avatar_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/update_user_usecase.dart';
import 'package:instagram_app/response/object_response.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase getUsersUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final FollowUnFollowUseCase followUnFollowUseCase;
  final UpdateUserAvatarUseCase updateUserAvatarUseCase;


  UserCubit(
      {required this.getUsersUseCase,
      required this.updateUserUseCase,
      required this.followUnFollowUseCase,
      required this.updateUserAvatarUseCase

      })
      : super(UserInitial());

  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUserAvatar({
    required File file,required String uid
  }) async {
    emit(UserLoading());
    ObjectResponse response = await updateUserAvatarUseCase.call(file, uid);
    if(response.status == Status.success) {
      emit(UserSuccess());
    }else if (response.status == Status.error) {
      emit(UserFailure());
    }

  }




  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> followUnFollowUser({required UserEntity user}) async {
    try {
      await followUnFollowUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  void onImageSelected(File imageFile) {
    emit(UserLoaded(
      avatarFile: imageFile,
      currentImagePath: imageFile.path,
      isPreview: true,
      users: const [],
    ));


  }


}

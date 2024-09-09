import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_app/app/enums/auth_status.dart';
import 'package:instagram_app/domain/entities/user/user_entity.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/sign_up_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUseCase signUpUseCase;

  CredentialCubit(
      {required this.signInUserUseCase, required this.signUpUseCase})
      : super(CredentialInitial());

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading()); // Phát ra trạng thái loading cho UI;
    try {
      AuthStatus authStatus =   await signInUserUseCase
          .call(UserEntity(email: email, password: password));
      if(authStatus == AuthStatus.success) {
        emit(CredentialSuccess());
      }
      if(authStatus == AuthStatus.invalidEmailOrPassword) {
          emit(CredentialFailure());
      }

      emit(CredentialSuccess()); // Phát ra trạng thái thành công
    } on SocketException catch (_) {
      emit(const CredentialFailure()); // Phát ra trạng thái thất bại
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      AuthStatus authStatus =  await signUpUseCase.call(user);
      if(authStatus == AuthStatus.success) {
        emit(CredentialSuccess());
      }else {
        emit(CredentialFailure(authStatus: authStatus));
      }
    } on SocketException catch (_) {
      emit(const CredentialFailure(authStatus: AuthStatus.error));
    } catch (_) {
      emit(const CredentialFailure(authStatus: AuthStatus.error));
    }
  }
}

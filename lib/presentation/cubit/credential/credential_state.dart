part of 'credential_cubit.dart';

// Quản lý thông tin xác thực

sealed class CredentialState extends Equatable {
  const CredentialState();
}

final class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

final class CredentialLoading extends CredentialState {
  @override
  List<Object?> get props => [];
}

final class CredentialSuccess extends CredentialState {
  @override
  List<Object?> get props => [];
}

final class CredentialFailure extends CredentialState {
  final AuthStatus? authStatus;

  const CredentialFailure({
    this.authStatus,
  });
  @override
  List<Object?> get props => [authStatus];


}





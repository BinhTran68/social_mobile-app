part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}



final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}


class UserLoaded extends UserState {
  final List<UserEntity> users;
  final File? avatarFile;
  final String? currentImagePath;
  final bool? isPreview;
  const UserLoaded({required this.users,
    this.avatarFile,
    this.currentImagePath,
    this.isPreview = false,
  });
  @override
  List<Object?> get props => [users, avatarFile, currentImagePath, isPreview];

}


class UserFailure extends UserState {
  Status? status;

   UserFailure({
    this.status =  Status.noStatus
  });

  @override
  List<Object> get props => [status!];
}


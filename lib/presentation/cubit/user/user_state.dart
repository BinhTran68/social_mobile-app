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


class UserLoaded extends UserState {
  final List<UserEntity> users;
  const UserLoaded({required this.users}); // trạng thái phát ra kèm theo 1 danh sách user
  @override
  List<Object> get props => [users];
}


class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}


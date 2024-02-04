part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

//user general state
class UserLoadingState extends UserState {}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetUserByIdSuccess<T> extends UserState {
  final T data;
  const GetUserByIdSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class UserCreated extends UserState {}

class GetCurrentUserSuccess extends UserState {}

class SetUserStatusSuccess extends UserState {}

class SetUserStatusError extends UserState {}

class UserDeleted extends UserState {}
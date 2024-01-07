import 'package:chat_app_flutter/features/data/models/account.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

//user general state
class UserLoadingState extends UserState {}

class UserLoadedState<T> extends UserState {
  final T data;
  UserLoadedState({required this.data});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({required this.message});
}

class UserCreated extends UserState {}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}

//profile state
class ProfileLoadingState extends UserState {}

class ProfileLoadedState<T> extends UserState {
  final T profile;
  ProfileLoadedState({required this.profile});
}

class ProfileErrorState extends UserState {
  final String message;
  ProfileErrorState({required this.message});
}

class ProfileUpdated extends UserState {}

//account state
class AccountLoadingState extends UserState {}

class AccountLoadedState extends UserState {
  final Account account;
  AccountLoadedState({required this.account});
}

class AccountErrorState extends UserState {
  final String message;
  AccountErrorState({required this.message});
}

class AccountUpdated extends UserState {}

class AccountDeleted extends UserState {}

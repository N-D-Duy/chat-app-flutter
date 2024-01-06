import 'package:chat_app_flutter/features/data/models/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

//user general state
class UserLoadingState extends UserState {}
class UserLoadedState extends UserState {
  final User user;
  UserLoadedState({required this.user});
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
class ProfileLoadedState extends UserState {
  final User user;
  ProfileLoadedState({required this.user});
}
class ProfileErrorState extends UserState {
  final String message;
  ProfileErrorState({required this.message});
}
class ProfileUpdated extends UserState {}

//account state
class AccountLoadingState extends UserState {}
class AccountLoadedState extends UserState {
  final User user;
  AccountLoadedState({required this.user});
}
class AccountErrorState extends UserState {
  final String message;
  AccountErrorState({required this.message});
}
class AccountUpdated extends UserState {}
class AccountDeleted extends UserState {}


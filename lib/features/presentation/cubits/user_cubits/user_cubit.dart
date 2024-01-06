import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:chat_app_flutter/features/presentation/cubits/user_cubits/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final usecase = di<UseCases>;
  UserCubit() : super(UserInitialState());

  Future<void> getUser(String uid) async {
    emit(UserLoadingState());
    final result = await usecase().user.getUser(uid);
    result.fold((failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(UserLoadedState(user: data)));
  }

  Future<void> createUser(User user) async {
    emit(UserLoadingState());
    final result = await usecase().user.insertUser(user);
    result.fold((failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(UserCreated()));
  }

  Future<void> updateUser(User user) async {
    emit(UserLoadingState());
    final result = await usecase().user.updateUser(user);
    result.fold((failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(UserUpdated()));
  }

  Future<void> deleteUser(String uid) async {
    emit(UserLoadingState());
    final result = await usecase().user.deleteUser(uid);
    result.fold((failure) => emit(UserErrorState(message: failure.message)),
        (data) => emit(UserDeleted()));
  }

  Future<void> getProfile(String uid) async {
    emit(ProfileLoadingState());
    final result = await usecase().user.getProfile(uid);
    result.fold((failure) => emit(ProfileErrorState(message: failure.message)),
        (data) => emit(ProfileLoadedState(user: data)));
  }

  Future<void> updateProfile(Profile profile, String uid) async {
    emit(ProfileLoadingState());
    final result = await usecase().user.updateProfile(profile, uid);
    result.fold((failure) => emit(ProfileErrorState(message: failure.message)),
        (data) => emit(ProfileUpdated()));
  }

  Future<void> insertProfile(Profile profile, String uid) async {
    emit(ProfileLoadingState());
    final result = await usecase().user.insertProfile(profile, uid);
    result.fold((failure) => emit(ProfileErrorState(message: failure.message)),
        (data) => emit(ProfileUpdated()));
  }

  Future<void> getAccount(String uid) async {
    emit(AccountLoadingState());
    final result = await usecase().user.getAccount(uid);
    result.fold((failure) => emit(AccountErrorState(message: failure.message)),
        (data) => emit(AccountLoadedState(user: data)));
  }

  Future<void> updateAccount(Account account, String uid) async {
    emit(AccountLoadingState());
    final result = await usecase().user.updateAccount(account, uid);
    result.fold((failure) => emit(AccountErrorState(message: failure.message)),
        (data) => emit(AccountUpdated()));
  }

  Future<void> insertAccount(Account account, String uid) async {
    emit(AccountLoadingState());
    final result = await usecase().user.insertAccount(account, uid);
    result.fold((failure) => emit(AccountErrorState(message: failure.message)),
        (data) => emit(AccountUpdated()));
  }
}

import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:chat_app_flutter/features/presentation/cubits/user_cubits/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final usecase = di<UseCases>;
  UserCubit() : super(UserInitialState());

  Future<void> getUsers() async {
    emit(UserLoadingState());
    await usecase().user.getUsers().then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(UserLoadedState(data: value.data))}
          else if (value.status == Status.ERROR)
            {emit(UserErrorState(message: value.message!))}
        });
  }

  Future<void> getUser(String uid) async {
    emit(UserLoadingState());
    await usecase().user.getUser(uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(UserLoadedState(data: value.data))}
          else if (value.status == Status.ERROR)
            {emit(UserErrorState(message: value.message!))}
        });
  }

  Future<void> createUser(User user) async {
    emit(UserLoadingState());
    await usecase().user.insertUser(user).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(UserCreated())}
          else if (value.status == Status.ERROR)
            {emit(UserErrorState(message: value.message!))}
        });
  }

  Future<void> updateUser(User user) async {
    emit(UserLoadingState());
    await usecase().user.updateUser(user).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(UserUpdated())}
          else if (value.status == Status.ERROR)
            {emit(UserErrorState(message: value.message!))}
        });
  }

  Future<void> deleteUser(String uid) async {
    emit(UserLoadingState());
    await usecase().user.deleteUser(uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(UserDeleted())}
          else if (value.status == Status.ERROR)
            {emit(UserErrorState(message: value.message!))}
        });
  }

  Future<void> getProfile(String uid) async {
    emit(ProfileLoadingState());
    await usecase().user.getProfile(uid).then((value) => {
          if (value.status == Status.SUCCESS)
            if (value.data != null)
              {emit(ProfileLoadedState(profile: value.data!))}
            else
              {
                emit(ProfileLoadedState(
                    profile: Profile.defaultConstructor().copyWith(uid: uid)))
              }
          else if (value.status == Status.ERROR)
            {emit(ProfileErrorState(message: value.message!))}
        });
  }

  Future<void> getProfiles() async {
    emit(ProfileLoadingState());
    List<Profile> list = [];
    await usecase().user.getProfiles().then((value) => {
          if (value.status == Status.SUCCESS)
            {
              if(value.data != null)
              {
                list = value.data!.map((e) => Profile.fromMap(e)).toList(),
                emit(ProfileLoadedState(profile: list))
              } else {
                emit(ProfileLoadedState(profile: []))
              }
            }
          else if (value.status == Status.ERROR)
            {emit(ProfileErrorState(message: value.message!))}
        });
  }

  Future<void> updateProfile(Profile profile, String uid) async {
    emit(ProfileLoadingState());
    await usecase().user.updateProfile(profile, uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ProfileUpdated())}
          else if (value.status == Status.ERROR)
            {emit(ProfileErrorState(message: value.message!))}
        });
  }

  Future<void> insertProfile(Profile profile, String uid) async {
    emit(ProfileLoadingState());
    await usecase().user.insertProfile(profile, uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ProfileUpdated())}
          else if (value.status == Status.ERROR)
            {emit(ProfileErrorState(message: value.message!))}
        });
  }

  Future<void> getAccount(String uid) async {
    emit(AccountLoadingState());
    await usecase().user.getAccount(uid).then((value) => {
          if (value.status == Status.SUCCESS)
            if (value.data != null)
              {emit(AccountLoadedState(account: value.data!))}
            else
              {
                emit(AccountLoadedState(
                    account: Account.defaultConstructorMethod()))
              }
          else if (value.status == Status.ERROR)
            {emit(AccountErrorState(message: value.message!))}
        });
  }

  Future<void> updateAccount(Account account, String uid) async {
    emit(AccountLoadingState());
    await usecase().user.updateAccount(account, uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(AccountUpdated())}
          else if (value.status == Status.ERROR)
            {emit(AccountErrorState(message: value.message!))}
        });
  }

  Future<void> insertAccount(Account account, String uid) async {
    emit(AccountLoadingState());
    await usecase().user.insertAccount(account, uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(AccountUpdated())}
          else if (value.status == Status.ERROR)
            {emit(AccountErrorState(message: value.message!))}
        });
  }
}

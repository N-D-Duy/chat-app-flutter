import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/profile_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final usecase = di<AppUseCases>;
  UserCubit() : super(UserInitialState());

  UserModel? userModel;
  Future<void> getCurrentUser() async {
    final result = await usecase()
        .user
        .getCurrentUserData(); //type: Either<Failure, UserModel>
    result.fold(
      (error) => emit(UserError(message: error.message)),
      (success) {
        userModel = success;
        emit(GetCurrentUserSuccess());
      },
    );
  }

  Stream<UserModel> getUserById(String id) {
    return usecase().user.getUserById(id);
  }

  Future<void> setUserStateStatus(bool isOnline) async {
    final result = await usecase().user.setUserStateStatus(isOnline);
    result.fold(
      (l) => emit(SetUserStatusError()),
      (r) => emit(SetUserStatusSuccess()),
    );
  }

  Future<void> updateProfileImage(String path) async{
    final result = usecase().user.updateProfileImage(path);
    result.fold(
        (l)=> emit(UserError(message: l.message)),
        (r)=> emit(UpdateProfileImageSuccess())
    );
  }

  Future<void> getProfile(String uid) async{
    emit(ProfileLoading());
    final result = await usecase().user.getProfile(uid);
    result.fold(
        (l)=> emit(UserError(message: l.message)),
        (r){
          emit(GetProfileSuccess(profile: r));
        }
    );
  }
}

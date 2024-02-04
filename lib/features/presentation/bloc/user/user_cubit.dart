import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/models/user_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final usecase = di<AppUseCases>;
  UserCubit() : super(UserInitialState());

  UserModel? userModel;
  Future<void> getCurrentUser() async {
    final result = await usecase().user.getCurrentUserData();
    result.fold(
      (error) => emit(UserError(message: error.message)),
      (success) {
        userModel = success;
        emit(GetCurrentUserSuccess());
      },
    );
  }

  //this function for get your friend data such as name, status, image etc for chat app bar status
  Stream<UserState> getUserById(String id) async* {
    yield UserLoadingState();
    try {
      final result = usecase().user.getUserById(id);
      yield GetUserByIdSuccess(data: result);
    } catch (e) {
      yield UserError(message: e.toString());
    }
  }

  Future<void> setUserStateStatus(bool isOnline) async {
    final result = await usecase().user.setUserStateStatus(isOnline);
    result.fold(
      (l) => emit(SetUserStatusError()),
      (r) => emit(SetUserStatusSuccess()),
    );
  }
}

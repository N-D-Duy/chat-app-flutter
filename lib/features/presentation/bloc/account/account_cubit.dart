import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final usecases = di<AppUseCases>;
  AccountCubit() : super(AccountInitialState());

  Future<void> changePassword(String newPassword) async {
    emit(AccountLoadingState());
    final result = await usecases().user.updateAccount(newPassword);
    result.fold(
      (error) => emit(AccountErrorState(message: error.message)),
      (success) => emit(AccountUpdated()),
    );
  }
}

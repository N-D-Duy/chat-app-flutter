import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:chat_app_flutter/features/domain/usecases/chat/chat_use_case.dart';
import 'package:chat_app_flutter/features/domain/usecases/user/auth/user_auth_cases.dart';
import 'package:chat_app_flutter/features/domain/usecases/user/case/user_use_case.dart';

class UseCases {
  final Repository _repository;
  late final ChatUseCase chat;
  late final UserUseCase user;
  late final UserAuth auth;

  UseCases(this._repository) {
    chat = ChatUseCase(_repository);
    user = UserUseCase(_repository);
    auth = UserAuth(_repository);
  }
}

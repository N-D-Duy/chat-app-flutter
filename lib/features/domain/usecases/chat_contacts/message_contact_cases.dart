import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/domain/models/chat_model.dart';
import 'package:chat_app_flutter/features/data/repositories/chat_contact_repository.dart';

class ChatContactsUseCase implements ChatContactRepository {
  final ChatContactRepository _repository;

  ChatContactsUseCase(this._repository);

  @override
  Stream<List<Chat>> getChatContacts() {
    return _repository.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    if (senderId.isEmpty) {
      throw DatabaseException('getNumOfMessageNotSeen: senderId is empty');
    } else {
      return _repository.getNumOfMessageNotSeen(senderId);
    }
  }
}

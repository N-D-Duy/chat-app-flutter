import 'package:chat_app_flutter/features/data/datasources/chat_contacts/chat_contacts.dart';
import 'package:chat_app_flutter/features/domain/models/chat_model.dart';
import 'package:chat_app_flutter/features/data/repositories/message_contact_repository.dart';

class MessageContactRepositoryImpl implements MessageContactRepository {
  final ChatContactsRemoteDataSource _messageContactDataSource;

  MessageContactRepositoryImpl(this._messageContactDataSource);

  @override
  Stream<List<Chat>> getChatContacts() {
    return _messageContactDataSource.getChatContacts();
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    return _messageContactDataSource.getNumOfMessageNotSeen(senderId);
  }
}

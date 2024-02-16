import 'package:chat_app_flutter/features/domain/models/chat_model.dart';

abstract class ChatContactRepository {
  Stream<List<Chat>> getChatContacts();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

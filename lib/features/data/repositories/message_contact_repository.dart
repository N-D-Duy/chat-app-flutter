import 'package:chat_app_flutter/features/data/models/chat_model.dart';

abstract class MessageContactRepository {
  Stream<List<Chat>> getChatContacts();
  Stream<int> getNumOfMessageNotSeen(String senderId);
}

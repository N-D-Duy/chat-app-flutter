import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:chat_app_flutter/core/error/exception/my_exception.dart';

class ChatUseCase {
  final Repository _repository;

  ChatUseCase(this._repository);

  Future<Resource<void>> deleteChat(String uid, String chatId) async {
    if (uid.isEmpty || chatId.isEmpty) {
      throw MyException('DeleteChat: uid or chatId is empty');
    } else {
      return _repository.deleteChat(uid, chatId);
    }
  }

  Future<Resource<void>> getChatsByUid(String uid) async {
    if (uid.isEmpty) {
      throw Exception('GetAllChatsUseCase: uid is empty');
    } else {
      return _repository.getChats(uid);
    }
  }

  Future<Resource<void>> getChatMessages(String chatId) async {
    if (chatId.isEmpty) {
      throw MyException('GetChatMessages: chatId is empty');
    }
    return _repository.getChatMessages(chatId);
  }

  Future<Resource<void>> insertChat(String uid1, String uid2, Chat chat) async {
    if (uid1.isEmpty || uid2.isEmpty) {
      throw MyException('InsertChat: uid1 or uid2 is empty');
    }
    return _repository.insertChat(uid1, uid2, chat);
  }

  Future<Resource<void>> insertChatMessage(
      String chatId, Map<String, dynamic> message) async {
    if (chatId.isEmpty) {
      throw MyException('InsertChatMessage: chatId is empty');
    }
    return _repository.insertChatMessage(chatId, message);
  }

  Future<Resource<void>> deleteMessage(String chatId, String messageId) async {
    if (chatId.isEmpty || messageId.isEmpty) {
      throw MyException('DeleteMessage: chatId or messageId is empty');
    }
    return _repository.deleteChatMessage(chatId, messageId);
  }


  
}

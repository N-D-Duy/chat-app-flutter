import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';

abstract class Firebase {
  //user
  Future<Resource<void>> insertUser(User user);
  Future<Resource<void>> updateUser(User user);
  Future<Resource<void>> deleteUser(String uid);
  Future<Resource<User>> getUser(String uid);
  Future<Resource<List<User>>> getUsers();

  //profile
  Future<Resource<void>> updateProfile(Profile newProfile, String uid);
  Future<Resource<Profile>> getProfile(String uid);
  Future<Resource<void>> insertProfile(Profile profile, String uid);


  //account
  Future<Resource<void>> updateAccount(Account newAccount, String uid);
  Future<Resource<Account>> getAccount(String uid);
  Future<Resource<void>> insertAccount(Account account, String uid);

  //chat
  Future<Resource<void>> insertChat(String uid1, String uid2, Chat chat);
  Future<Resource<void>> deleteChat(String uid, String chatId);
  Future<Resource<List<Map<String, dynamic>>>> getChats(String uid);
  Future<Resource<List<Map<String, dynamic>>>> getChatMessages(String chatId);
  Future<Resource<void>> insertChatMessage(String chatId, Map<String, dynamic> message);
  Future<Resource<void>> deleteChatMessage(String chatId, String messageId);
}

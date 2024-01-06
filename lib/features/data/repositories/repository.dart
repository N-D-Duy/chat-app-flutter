

import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

abstract class Repository {
  Future<Resource<void>> insertUser(model.User user);
  Future<Resource<void>> updateUser(model.User user);
  Future<Resource<void>> deleteUser(String uid);
  Future<Resource<model.User>> getUser(String uid);
  Future<Resource<List<model.User>>> getUsers();

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

  //auth
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<User?> getCurrentUser();

}

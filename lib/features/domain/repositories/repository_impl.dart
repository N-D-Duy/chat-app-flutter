import 'package:chat_app_flutter/features/data/datasources/local/sharedpref/shared_preferences_helper.dart';
import 'package:chat_app_flutter/features/data/datasources/remote/firebase/auth/auth_service.dart';
import 'package:chat_app_flutter/features/data/datasources/remote/firebase_database_impl.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart' as models;
import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryImpl extends Repository {
  @override
  Future<Resource<void>> deleteChat(String uid, String chatId) async {
    return await FirebaseImpl().deleteChat(uid, chatId);
  }

  @override
  Future<Resource<void>> deleteUser(String uid) async {
    return await FirebaseImpl().deleteUser(uid);
  }

  @override
  Future<Resource<Account>> getAccount(String uid) async {
    return await FirebaseImpl().getAccount(uid);
  }

  @override
  Future<Resource<List<Map<String, dynamic>>>> getChats(String uid) async {
    return await FirebaseImpl().getChats(uid);
  }

  @override
  Future<User?> getCurrentUser() async {
    return await AuthService().getCurrentUser();
  }

  @override
  Future<Resource<Profile>> getProfile(String uid) async {
    return await FirebaseImpl().getProfile(uid);
  }

  @override
  Future<Resource<models.User>> getUser(String uid) async {
    return await FirebaseImpl().getUser(uid);
  }

  @override
  Future<Resource<List<models.User>>> getUsers() async {
    return await FirebaseImpl().getUsers();
  }

  @override
  Future<Resource<void>> insertAccount(Account account, String uid) async {
    return await FirebaseImpl().insertAccount(account, uid);
  }

  @override
  Future<Resource<void>> insertChat(String uid1, String uid2, Chat chat) async {
    return await FirebaseImpl().insertChat(uid1, uid2, chat);
  }

  @override
  Future<Resource<void>> insertProfile(Profile profile, String uid) async {
    return await FirebaseImpl().insertProfile(profile, uid);
  }

  @override
  Future<Resource<void>> insertUser(models.User user) async {
    return await FirebaseImpl().insertUser(user);
  }

  @override
  Future<bool> isSignedIn() async {
    return await SharedPreferencesHelper.isUserLoggedIn();
  }

  @override
  Future<UserCredential> signIn(String email, String password) {
    return AuthService().signInWithEmail(email, password);
  }

  @override
  Future<void> signOut() {
    return AuthService().signOut();
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    return AuthService().signUpWithEmail(email, password);
  }

  @override
  Future<Resource<void>> updateAccount(Account newAccount, String uid) async {
    return await FirebaseImpl().updateAccount(newAccount, uid);
  }

  @override
  Future<Resource<void>> updateProfile(Profile newProfile, String uid) async {
    return await FirebaseImpl().updateProfile(newProfile, uid);
  }

  @override
  Future<Resource<void>> updateUser(models.User user) async {
    return await FirebaseImpl().updateUser(user);
  }

  @override
  Future<Resource<void>> deleteChatMessage(
      String chatId, String messageId) async {
    return await FirebaseImpl().deleteChatMessage(chatId, messageId);
  }

  @override
  Future<Resource<List<Map<String, dynamic>>>> getChatMessages(
      String chatId) async {
    return await FirebaseImpl().getChatMessages(chatId);
  }

  @override
  Future<Resource<void>> insertChatMessage(
      String chatId, Map<String, dynamic> message) async {
    return await FirebaseImpl().insertChatMessage(chatId, message);
  }
}

import 'package:chat_app_flutter/core/constants/firebase_ref.dart';
import 'package:chat_app_flutter/features/data/datasources/remote/firebase_database.dart';
import 'package:chat_app_flutter/features/data/datasources/remote/firebase/firebase_service.dart';
import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseImpl extends Firebase {
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  final DatabaseReference _databaseReference = FirebaseService.database.ref();

  //chat and messages saved in realtime database
  //user saved in firestore
  @override
  Future<Resource<void>> deleteChat(String uid, String chatId) async {
    try {
      String chatId = await _firestore
          .collection('users')
          .doc(uid)
          .get()
          .then((snapshot) => snapshot.data()?['chatId']);
      await _databaseReference.child('chats').child(chatId).remove();
      return Resource(Status.SUCCESS, null, 'Chat deleted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      return Resource(Status.SUCCESS, null, 'User deleted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<List<Map<String, dynamic>>>> getChats(String uid) async {
    try {
      List<Map<String, dynamic>> chats = [];
      List<String> chatIds = await _firestore
          .collection('users')
          .doc(uid)
          .get()
          .then((snapshot) => List.from(snapshot.data()?['chats']));
      for (String chatId in chatIds) {
        Map<String, dynamic> chat = await _databaseReference
            .child('chats')
            .child(chatId)
            .get()
            .then((snapshot) => snapshot.value as Map<String, dynamic>);
        chats.add(chat);
      }
      return Resource(Status.SUCCESS, chats, 'Chats retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<User>> getUser(String uid) async {
    try {
      User user = await _firestore
          .collection('users')
          .doc(uid)
          .get()
          .then((snapshot) => User.fromMap(snapshot.data()!));
      return Resource(Status.SUCCESS, user, 'User retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<List<User>>> getUsers() async {
    try {
      List<User> users = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('users').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        users.add(User.fromMap(snapshot.data()));
      }
      return Resource(Status.SUCCESS, users, 'Users retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> insertChat(String uid1, String uid2, Chat chat) async {
    try {
      DatabaseReference chatRef = _databaseReference.child('chats').push();
      chat.chatId = chatRef.key!;
      await chatRef.set(chat.toMap());

      // Update list of chats for user1 in Firestore
      await _firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(uid1)
          .update({
        'chats': FieldValue.arrayUnion([chatRef.key])
      });

      // Update list of chats for user2 in Firestore
      await _firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(uid2)
          .update({
        'chats': FieldValue.arrayUnion([chatRef.key])
      });
      return Resource(Status.SUCCESS, null, 'Chat inserted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> insertUser(User user) async {
    try {
      await _firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(user.uid)
          .set(user.toMap());
      return Resource(Status.SUCCESS, null, 'User inserted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> updateUser(User user) async {
    try {
      await _firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(user.uid)
          .update(user.toMap());
      return Resource(Status.SUCCESS, null, 'User updated successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> updateAccount(Account newAccount, String uid) async {
    try {
      await _firestore
          .collection(FirebaseRef.ACCOUNT_COLLECTION)
          .doc(uid)
          .update(newAccount.toMap());
      return Resource(Status.SUCCESS, null, 'Account updated successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> updateProfile(Profile newProfile, String uid) async {
    try {
      await _firestore
          .collection(FirebaseRef.PROFILE_COLLECTION)
          .doc(uid)
          .update(newProfile.toMap());
      return Resource(Status.SUCCESS, null, 'Profile updated successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<Account>> getAccount(String uid) async {
    try {
      Account account = await _firestore
          .collection(FirebaseRef.ACCOUNT_COLLECTION)
          .doc(uid)
          .get()
          .then((snapshot) => Account.fromMap(snapshot.data()!));
      return Resource(
          Status.SUCCESS, account, 'Account retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<Profile>> getProfile(String uid) async {
    try {
      Profile profile = await _firestore
          .collection(FirebaseRef.PROFILE_COLLECTION)
          .doc(uid)
          .get()
          .then((snapshot) => Profile.fromMap(snapshot.data()!));
      return Resource(
          Status.SUCCESS, profile, 'Profile retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> insertAccount(Account account, String uid) async {
    try {
      await _firestore
          .collection(FirebaseRef.ACCOUNT_COLLECTION)
          .doc(uid)
          .set(account.toMap());
      return Resource(Status.SUCCESS, null, 'Account inserted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> insertProfile(Profile profile, String uid) async {
    try {
      await _firestore
          .collection(FirebaseRef.PROFILE_COLLECTION)
          .doc(uid)
          .set(profile.toMap());
      return Resource(Status.SUCCESS, null, 'Profile inserted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> deleteChatMessage(
      String chatId, String messageId) async {
    try {
      await _databaseReference
          .child('chats')
          .child(chatId)
          .child('messages')
          .child(messageId)
          .remove();
      await _databaseReference
          .child(FirebaseRef.MESSAGE_COLLECTION)
          .child(messageId)
          .remove();
      return Resource(
          Status.SUCCESS, null, 'Chat message deleted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<List<Map<String, dynamic>>>> getChatMessages(
      String chatId) async {
    try {
      List<Map<String, dynamic>> messages = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          (await _databaseReference
              .child(FirebaseRef.CHAT_COLLECTION)
              .child(chatId)
              .child('messages')
              .get()) as QuerySnapshot<Map<String, dynamic>>;
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        messages.add(snapshot.data());
      }
      return Resource(
          Status.SUCCESS, messages, 'Chat messages retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<void>> insertChatMessage(
      String chatId, Map<String, dynamic> message) async {
    try {
      DatabaseReference messageRef =
          _databaseReference.child(FirebaseRef.MESSAGE_COLLECTION).push();
      message['messageId'] = messageRef.key;
      message['timestamp'] = DateTime.now().millisecondsSinceEpoch;
      messageRef.set(message);

      await _databaseReference
          .child(FirebaseRef.CHAT_COLLECTION)
          .child(chatId)
          .child('lastMessage')
          .set(message);

      await _databaseReference
          .child(FirebaseRef.CHAT_COLLECTION)
          .child(chatId)
          .child('messages')
          .child(messageRef.key!)
          .set(message);
      return Resource(
          Status.SUCCESS, null, 'Chat message inserted successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }

  @override
  Future<Resource<List<Map<String, dynamic>>>> getProfiles() async {
    try {
      List<Map<String, dynamic>> profiles = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('profiles').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        profiles.add(snapshot.data());
      }
      return Resource(
          Status.SUCCESS, profiles, 'Profiles retrieved successfully');
    } on FirebaseException catch (e) {
      return Resource(Status.ERROR, null, e.toString());
    }
  }
}

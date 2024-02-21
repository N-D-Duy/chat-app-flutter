import 'dart:io';

import 'package:chat_app_flutter/core/utils/constants/firebase_ref.dart';
import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:chat_app_flutter/features/domain/models/account_model.dart';
import 'package:chat_app_flutter/features/domain/models/profile_model.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
  Future<void> updateProfile(Profile newProfile);
  Future<void> updateAccount(String newPassword);
  Future<Profile> getProfile(String uid);
  Future<void> insertProfile(Profile profile);
  Future<void> insertAccount(Account account);
  Future<void> insertUser(UserModel user);
  Future<void> updateProfileImage(String path);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final firestore = FirebaseService.firestore;
  final fireStorage = FirebaseService.storage;
  final auth = FirebaseService.auth;
  @override
  Future<UserModel?> getCurrentUserData() async {
    UserModel? userData;
    try {
      userData = await firestore
          .collection(FirebaseRef.USER_COLLECTION)
          .doc(auth.currentUser?.uid)
          .get()
          .then((value) => UserModel.fromMap(value.data()!));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    // ignore: avoid_print
    print(userData?.uid);

    return userData;
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  @override
  Future<void> setUserStateStatus(bool isOnline) async {
    await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({
      'isOnline': isOnline,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> updateAccount(String newPassword) async {
    await firestore
        .collection(FirebaseRef.ACCOUNT_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update({'password': newPassword});
  }

  @override
  Future<void> updateProfile(Profile newProfile) async {
    await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .update(newProfile.toMap());
  }

  @override
  Future<Profile> getProfile(String uid) async {
    return await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(uid)
        .get()
        .then((value) => Profile.fromMap(value.data()!));
  }

  @override
  Future<void> insertProfile(Profile profile) async {
    await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .set(profile.toMap());
  }

  @override
  Future<void> insertAccount(Account account) async {
    await firestore
        .collection(FirebaseRef.ACCOUNT_COLLECTION)
        .doc(auth.currentUser!.uid)
        .set(account.toMap());
  }

  @override
  Future<void> insertUser(UserModel user) async {
    return await firestore
        .collection(FirebaseRef.USER_COLLECTION)
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<void> updateProfileImage(String path) async {
    String uid = auth.currentUser!.uid;
    //The method first deletes the previous profile picture by checking if the user has a profile picture and calling the _deleteFileFromFirebase method
    // to remove the file from Firebase storage.
    var userData = await firestore.collection('users').doc(uid).get();
    UserModel user = UserModel.fromMap(userData.data()!);
    if(user.profileImage.isNotEmpty && user.profileImage != 'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'){
      await _deleteFileFromFirebase(user.profileImage);
    }
    //Then it uploads the new profile picture using the _storeFileToFirebase method and stores the download URL of the new picture in the Firestore database.
    String photoUrl = await _storeFileToFirebase(
      'profilePicture/$uid',
      File(path),
    );
    await firestore.collection(FirebaseRef.USER_COLLECTION).doc(auth.currentUser!.uid).update({
      'profileImage': photoUrl,
    });
    await firestore.collection(FirebaseRef.PROFILE_COLLECTION).doc(auth.currentUser!.uid).update({
      'avatar': photoUrl,
    });

    //update the profileUrl in status collection
    await firestore.collection("status").where('uid', isEqualTo: uid).get().then((value) {
      for(var doc in value.docs){
        firestore.collection("status").doc(doc.id).update({
          'profilePicture': photoUrl,
        });
      }
    });

    updateProfileImageInChat(uid, photoUrl);
  }

  Future<void> updateProfileImageInChat(String uid, String photoUrl) async {
    var chats = await firestore.collection(FirebaseRef.USER_COLLECTION).doc(uid).collection('chats').get();
    for(var chat in chats.docs){
      //update the profileUrl field of chat documents which chat.id matched uid
      await firestore.collection(FirebaseRef.USER_COLLECTION).doc(uid).collection('chats').doc(chat.id).update({
        'profileUrl': photoUrl,
      });
    }
  }

  //This is method deletes a file from Firebase Storage.
  Future<void> _deleteFileFromFirebase(String path)async{
    return await fireStorage.refFromURL(path).delete();
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    UploadTask uploadTask = fireStorage.ref().child(path).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    //return the download URL of the uploaded file
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

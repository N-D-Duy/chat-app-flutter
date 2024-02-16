import 'package:chat_app_flutter/core/utils/constants/firebase_ref.dart';
import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:chat_app_flutter/features/domain/models/account_model.dart';
import 'package:chat_app_flutter/features/domain/models/profile_model.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<void> setUserStateStatus(bool isOnline);
  Future<void> updateProfile(Profile newProfile);
  Future<void> updateAccount(String newPassword);
  Future<Profile> getProfile();
  Future<void> insertProfile(Profile profile);
  Future<void> insertAccount(Account account);
  Future<void> insertUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final firestore = FirebaseService.firestore;
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
  Future<Profile> getProfile() async {
    return await firestore
        .collection(FirebaseRef.PROFILE_COLLECTION)
        .doc(auth.currentUser!.uid)
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
}

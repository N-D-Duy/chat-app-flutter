import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';

abstract class ContactsRemoteDataSource {
  Future<List<UserModel>> getAllContacts();
}

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  final _firebaseFirestore = FirebaseService.firestore;
  final _firebaseAuth = FirebaseService.auth;
  @override
  Future<List<UserModel>> getAllContacts() async {
    //get all exists contacts by get all users from firebase
    final List<UserModel> allUsers = [];
    final users = await _firebaseFirestore.collection('users').get();
    for (var user in users.docs) {
      if (user.id != _firebaseAuth.currentUser!.uid) {
        //convert to Contact object
        final result = UserModel.fromMap(user.data());
        allUsers.add(result);
      }
    }
    return allUsers;
  }
}

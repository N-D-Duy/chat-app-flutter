import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class ContactsRemoteDataSource {
  Future<List<Contact>> getAllContacts();
}

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  final _firebaseFirestore = FirebaseService.firestore;
  final _firebaseAuth = FirebaseService.auth;
  @override
  Future<List<Contact>> getAllContacts() async {
    //get all exists contacts by get all users from firebase
    final List<Contact> allUsers = [];
    final users = await _firebaseFirestore.collection('users').get();
    for (var user in users.docs) {
      if (user.id != _firebaseAuth.currentUser!.uid) {
        //convert to Contact object
        final contact = Contact(
          id: user.id,
          displayName: user['displayName'],
          photo: user['profileImage'],
          phones: [user['phoneNumber']],
          emails: [user['email']],
        );
        allUsers.add(contact);
      }
    }
    return allUsers;
  }
}

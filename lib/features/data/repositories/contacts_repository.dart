import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_contacts/contact.dart';

abstract class ContactsRepository {
  Future<Either<Failure, List<Contact>>> getAllContacts();
}

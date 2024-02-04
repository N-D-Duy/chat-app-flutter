import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/repositories/contacts_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_contacts/contact.dart';

class ContactsUseCase {
  final ContactsRepository _contactsRepository;

  ContactsUseCase(this._contactsRepository);

  Future<Either<Failure, List<Contact>>> getAllContacts() async {
    return await _contactsRepository.getAllContacts();
  }
}

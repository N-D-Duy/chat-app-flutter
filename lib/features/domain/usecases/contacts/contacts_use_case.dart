import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/repositories/contacts_repository.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:either_dart/either.dart';

class ContactsUseCase {
  final ContactsRepository _contactsRepository;

  ContactsUseCase(this._contactsRepository);

  Future<Either<Failure, List<UserModel>>> getAllContacts() async {
    return await _contactsRepository.getAllContacts();
  }
}

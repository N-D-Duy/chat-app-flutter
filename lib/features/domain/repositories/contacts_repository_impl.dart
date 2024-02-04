import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/datasources/contacts/contacts_data_source.dart';
import 'package:chat_app_flutter/features/data/repositories/contacts_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl(this.contactsRemoteDataSource);

  @override
  Future<Either<Failure, List<Contact>>> getAllContacts() async {
    try {
      final result = await contactsRemoteDataSource.getAllContacts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

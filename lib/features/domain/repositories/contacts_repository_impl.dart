import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/data/datasources/contacts/contacts_data_source.dart';
import 'package:chat_app_flutter/features/data/repositories/contacts_repository.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:either_dart/either.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl(this.contactsRemoteDataSource);

  @override
  Future<Either<Failure, List<UserModel>>> getAllContacts() async {
    try {
      final result = await contactsRemoteDataSource.getAllContacts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

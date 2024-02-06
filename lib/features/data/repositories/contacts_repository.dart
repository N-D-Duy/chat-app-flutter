import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:either_dart/either.dart';

abstract class ContactsRepository {
  Future<Either<Failure, List<UserModel>>> getAllContacts();
}

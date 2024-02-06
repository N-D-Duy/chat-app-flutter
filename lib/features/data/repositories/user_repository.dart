import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/domain/models/account_model.dart';
import 'package:chat_app_flutter/features/domain/models/profile_model.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:either_dart/either.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline);
  Future<Either<Failure, void>> updateProfile(Profile newProfile);
  Future<Either<Failure, void>> updateAccount(String newPassword);
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, void>> insertProfile(Profile profile);
  Future<Either<Failure, void>> insertAccount(Account account);
  Future<Either<Failure, void>> insertUser(UserModel user);
}

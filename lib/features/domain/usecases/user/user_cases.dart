import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/data/models/account_model.dart';
import 'package:chat_app_flutter/features/data/models/profile_model.dart';
import 'package:chat_app_flutter/features/data/models/user_model.dart';
import 'package:chat_app_flutter/features/data/repositories/user_repository.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class UserUseCase implements UserRepository {
  final UserRepository _repository;

  UserUseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() {
    return _repository.getCurrentUserData();
  }

  @override
  Future<Either<Failure, Profile>> getProfile() {
    return _repository.getProfile();
  }

  @override
  Stream<UserModel> getUserById(String id) {
    if (id.isEmpty) {
      throw DatabaseException('getUserById: id is empty');
    } else {
      return _repository.getUserById(id);
    }
  }

  @override
  Future<Either<Failure, void>> insertAccount(Account account) {
    if (account.email.isEmpty || account.password.isEmpty) {
      throw DatabaseException('insertAccount: email or password is empty');
    } else {
      return _repository.insertAccount(account);
    }
  }

  @override
  Future<Either<Failure, void>> insertProfile(Profile profile) {
    if (profile.userName.isEmpty) {
      throw DatabaseException('insertProfile: userName is empty');
    } else {
      return _repository.insertProfile(profile);
    }
  }

  @override
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline) {
    return _repository.setUserStateStatus(isOnline);
  }

  @override
  Future<Either<Failure, void>> updateAccount(String newPassword) {
    if (newPassword.isEmpty) {
      throw DatabaseException('updateAccount: newPassword is empty');
    } else {
      return _repository.updateAccount(newPassword);
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(Profile newProfile) {
    if (newProfile.userName.isEmpty) {
      throw DatabaseException('updateProfile: userName is empty');
    } else {
      return _repository.updateProfile(newProfile);
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserModel user) {
    if (user.uid.isEmpty) {
      throw DatabaseException('insertUser: uid is empty');
    } else {
      return _repository.insertUser(user);
    }
  }
}

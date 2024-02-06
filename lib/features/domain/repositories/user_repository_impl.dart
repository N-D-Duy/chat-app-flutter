import 'package:chat_app_flutter/features/data/datasources/user/user_data_source.dart';
// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

import 'package:chat_app_flutter/core/utils/error/exception/failure.dart';
import 'package:chat_app_flutter/features/domain/models/account_model.dart';
import 'package:chat_app_flutter/features/domain/models/profile_model.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  UserRepositoryImpl(this._userRemoteDataSource);
  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async {
    try {
      final result = await _userRemoteDataSource.getCurrentUserData();
      return Right(result!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final result = await _userRemoteDataSource.getProfile();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return _userRemoteDataSource.getUserById(id);
  }

  @override
  Future<Either<Failure, void>> insertAccount(Account account) async {
    try {
      final result = await _userRemoteDataSource.insertAccount(account);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertProfile(Profile profile) async {
    try {
      final result = await _userRemoteDataSource.insertProfile(profile);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline) async {
    try {
      final result = await _userRemoteDataSource.setUserStateStatus(isOnline);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccount(String newPassword) async {
    try {
      final result = await _userRemoteDataSource.updateAccount(newPassword);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(Profile newProfile) async {
    try {
      final result = await _userRemoteDataSource.updateProfile(newProfile);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserModel user) async {
    try {
      final result = await _userRemoteDataSource.insertUser(user);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:chat_app_flutter/features/data/repositories/repository.dart';
import 'package:chat_app_flutter/core/error/exception/my_exception.dart';

class UserUseCase {
  final Repository _repository;

  UserUseCase(this._repository);

  Future<Resource<void>> insertUser(User user) async {
    if (user.uid.isEmpty) {
      throw MyException('InsertUser: uid is empty');
    } else {
      return _repository.insertUser(user);
    }
  }

  Future<Resource<void>> updateUser(User user) async {
    if (user.uid.isEmpty) {
      throw MyException('UpdateUser: uid is empty');
    } else {
      return _repository.updateUser(user);
    }
  }

  Future<Resource<void>> deleteUser(String uid) async {
    if (uid.isEmpty) {
      throw MyException('DeleteUser: uid is empty');
    } else {
      return _repository.deleteUser(uid);
    }
  }

  Future<Resource<User>> getUser(String uid) async {
    if (uid.isEmpty) {
      throw MyException('GetUser: uid is empty');
    } else {
      return _repository.getUser(uid);
    }
  }

  Future<Resource<List<User>>> getUsers() async {
    return _repository.getUsers();
  }

  //profile
  Future<Resource<void>> updateProfile(Profile newProfile, String uid) async {
    if (uid.isEmpty) {
      throw MyException('UpdateProfile: uid is empty');
    } else {
      return _repository.updateProfile(newProfile, uid);
    }
  }

  Future<Resource<Profile>> getProfile(String uid) async {
    if (uid.isEmpty) {
      throw MyException('GetProfile: uid is empty');
    } else {
      return _repository.getProfile(uid);
    }
  }

  Future<Resource<void>> insertProfile(Profile profile, String uid) async {
    if (uid.isEmpty) {
      throw MyException('InsertProfile: uid is empty');
    } else {
      return _repository.insertProfile(profile, uid);
    }
  }

  //account
  Future<Resource<void>> updateAccount(Account newAccount, String uid) async {
    if (uid.isEmpty) {
      throw MyException('UpdateAccount: uid is empty');
    } else {
      return _repository.updateAccount(newAccount, uid);
    }
  }

  Future<Resource<Account>> getAccount(String uid) async {
    if (uid.isEmpty) {
      throw MyException('GetAccount: uid is empty');
    } else {
      return _repository.getAccount(uid);
    }
  }

  Future<Resource<void>> insertAccount(Account account, String uid) async {
    if (uid.isEmpty) {
      throw MyException('InsertAccount: uid is empty');
    } else {
      return _repository.insertAccount(account, uid);
    }
  }
}

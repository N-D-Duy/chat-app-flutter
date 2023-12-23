import 'package:chat_app_flutter/core/error/check_invalid/invalid_impl.dart';
import 'package:chat_app_flutter/core/error/exception/account_exception.dart';

class AccountExceptionImpl implements AccountException {
  final String message;
  AccountExceptionImpl(this.message);
  
  @override
  void passwordCheck(String password) {
    if(password.isEmpty) {
      throw AccountExceptionImpl('Password must not be empty');
    }
    if(password.length < 8) {
      throw AccountExceptionImpl('Password must be at least 8 characters');
    }
    if(!InvalidImpl().passwordCheck(password)) {
      throw AccountExceptionImpl('Password must contain at least 1 letter and 1 number');
    }
  }
  
  @override
  void profileNameCheck(String profileName) {
    if(profileName.isEmpty) {
      throw AccountExceptionImpl('Profile name must not be empty');
    }
    if(!InvalidImpl().profileNameCheck(profileName)) {
      throw AccountExceptionImpl('Profile name must not contain special characters');
    }
  }
  
  @override
  void userNameCheck(String username) {
    if(username.isEmpty) {
      throw AccountExceptionImpl('Username must not be empty');
    }
    if(username.length < 6) {
      throw AccountExceptionImpl('Username must be at least 6 characters');
    }
    if(!InvalidImpl().userNameCheck(username)) {
      throw AccountExceptionImpl('Username must not contain special characters');
    }
  }
}
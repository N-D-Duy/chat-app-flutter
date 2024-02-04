import 'package:chat_app_flutter/core/utils/error/check_invalid/invalid.dart';

class InvalidImpl implements Invalid {
  @override
  bool passwordCheck(String password) {
    final RegExp regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$');
    return regex.hasMatch(password);
  }

  @override
  bool profileNameCheck(String profileName) {
    return true; //
  }

  @override
  bool userNameCheck(String username) {
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    return usernameRegExp.hasMatch(username);
  }
}

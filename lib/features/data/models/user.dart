import 'package:chat_app_flutter/features/data/models/account.dart';

class User {
  final String userName;
  final String avatar;
  final Account account;
  bool hasSpecialBorder;
  User(this.hasSpecialBorder,
      {required this.userName, required this.avatar, required this.account});
  void setSpecialBorder(bool hasSpecialBorder) {
    this.hasSpecialBorder = hasSpecialBorder;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';

class User {
  String id;
  String userName;
  Account account;
  Profile? profile;
  User({
    required this.id,
    required this.userName,
    required this.account,
    this.profile,
  });

  User copyWith({
    String? id,
    String? userName,
    Account? account,
    Profile? profile,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      account: account ?? this.account,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'account': account.toMap(),
      'profile': profile?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      userName: map['userName'] as String,
      account: Account.fromMap(map['account'] as Map<String,dynamic>),
      profile: map['profile'] != null ? Profile.fromMap(map['profile'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, account: $account, profile: $profile)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userName == userName &&
      other.account == account &&
      other.profile == profile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userName.hashCode ^
      account.hashCode ^
      profile.hashCode;
  }
}

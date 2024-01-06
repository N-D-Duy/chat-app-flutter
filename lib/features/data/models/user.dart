// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String uid;
  String userName;
  List<String> chats;
  User({
    required this.uid,
    required this.userName,
    required this.chats,
  });

  User copyWith({
    String? uid,
    String? userName,
    List<String>? chats,
  }) {
    return User(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      chats: chats ?? this.chats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'chats': chats,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      chats: List<String>.from((map['chats'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(uid: $uid, userName: $userName, chats: $chats)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.userName == userName &&
      listEquals(other.chats, chats);
  }

  @override
  int get hashCode => uid.hashCode ^ userName.hashCode ^ chats.hashCode;
}

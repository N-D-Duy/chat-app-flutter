// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:chat_app_flutter/features/domain/models/status_model.dart';

class UserModel {
  String uid;
  String userName;
  String profileImage;
  final DateTime lastSeen;
  final List<String> groupId;
  final bool isOnline;
  UserModel({
    required this.uid,
    required this.userName,
    required this.profileImage,
    required this.lastSeen,
    required this.groupId,
    required this.isOnline,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? profileImage,
    DateTime? lastSeen,
    List<String>? groupId,
    StatusModel? status,
    bool? isOnline,
    List<String>? chats,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      profileImage: profileImage ?? this.profileImage,
      lastSeen: lastSeen ?? this.lastSeen,
      groupId: groupId ?? this.groupId,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'profileImage': profileImage,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'groupId': groupId,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      profileImage: map['profileImage'] as String,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen'] as int),
      groupId:
          (map['groupId'] as List<dynamic>).map((e) => e as String).toList(),
      isOnline: map['isOnline'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, profileImage: $profileImage, lastSeen: $lastSeen, groupId: $groupId, isOnline: $isOnline)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.profileImage == profileImage &&
        other.lastSeen == lastSeen &&
        listEquals(other.groupId, groupId) &&
        other.isOnline == isOnline;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        profileImage.hashCode ^
        lastSeen.hashCode ^
        groupId.hashCode ^
        isOnline.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:chat_app_flutter/features/data/models/status_model.dart';

class UserModel {
  String uid;
  String userName;
  String? profileImage;
  final String lastSeen;
  final List<String> groupId;
  final StatusModel status;
  final bool isOnline;
  List<String> chats;
  UserModel({
    required this.uid,
    required this.userName,
    required this.profileImage,
    required this.lastSeen,
    required this.groupId,
    required this.status,
    required this.isOnline,
    required this.chats,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? profileImage,
    String? lastSeen,
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
      status: status ?? this.status,
      isOnline: isOnline ?? this.isOnline,
      chats: chats ?? this.chats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'profileImage': profileImage,
      'lastSeen': lastSeen,
      'groupId': groupId,
      'status': status.toMap(),
      'isOnline': isOnline,
      'chats': chats,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      profileImage: map['profileImage'] as String,
      lastSeen: map['lastSeen'] as String,
      groupId: List<String>.from((map['groupId'] as List<String>)),
      status: StatusModel.fromMap(map['status'] as Map<String, dynamic>),
      isOnline: map['isOnline'] as bool,
      chats: List<String>.from((map['chats'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, userName: $userName, profileImage: $profileImage, lastSeen: $lastSeen, groupId: $groupId, status: $status, isOnline: $isOnline, chats: $chats)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.profileImage == profileImage &&
        other.lastSeen == lastSeen &&
        listEquals(other.groupId, groupId) &&
        other.status == status &&
        other.isOnline == isOnline &&
        listEquals(other.chats, chats);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        profileImage.hashCode ^
        lastSeen.hashCode ^
        groupId.hashCode ^
        status.hashCode ^
        isOnline.hashCode ^
        chats.hashCode;
  }
}

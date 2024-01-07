// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chat {
  String chatId;
  final String currentUserId;
  final String otherUserId;
  final List<String> messages;
  final String time;
  final int unreadMessage;

  Chat({
    required this.chatId,
    required this.currentUserId,
    required this.otherUserId,
    required this.messages,
    required this.time,
    required this.unreadMessage,
  });

  Chat copyWith({
    String? chatId,
    String? currentUserId,
    String? otherUserId,
    List<String>? messageId,
    String? time,
    int? unreadMessage,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      currentUserId: currentUserId ?? this.currentUserId,
      otherUserId: otherUserId ?? this.otherUserId,
      messages: messageId ?? messages,
      time: time ?? this.time,
      unreadMessage: unreadMessage ?? this.unreadMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'currentUserId': currentUserId,
      'otherUserId': otherUserId,
      'messageId': messages,
      'time': time,
      'unreadMessage': unreadMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      chatId: map['chatId'] as String? ?? '',
      currentUserId: map['currentUserId'] as String? ?? '',
      otherUserId: map['otherUserId'] as String? ?? '',
      messages: (map['messageId'] as List<dynamic>?)
              ?.map((message) => message.toString())
              .toList() ??
          [],
      time: map['time'] as String? ?? '',
      unreadMessage: map['unreadMessage'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(chatId: $chatId, currentUserId: $currentUserId, otherUserId: $otherUserId, messageId: $messages, time: $time, unreadMessage: $unreadMessage)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.currentUserId == currentUserId &&
        other.otherUserId == otherUserId &&
        listEquals(other.messages, messages) &&
        other.time == time &&
        other.unreadMessage == unreadMessage;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        currentUserId.hashCode ^
        otherUserId.hashCode ^
        messages.hashCode ^
        time.hashCode ^
        unreadMessage.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat_app_flutter/core/utils/enum/message_type.dart';

class Message {
  final String messageId;
  final String content;
  final String senderId;
  final String senderName;
  final String receiverId;
  final DateTime timeSent;
  final bool isRead;
  final MessageType messageType;
  //
  final MessageType replyMessageType;
  final String replyMessage;
  final String replyTo;
  Message({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.timeSent,
    required this.isRead,
    required this.messageType,
    required this.replyMessageType,
    required this.replyMessage,
    required this.replyTo,
  });

  Message copyWith({
    String? messageId,
    String? content,
    String? senderId,
    String? senderName,
    String? receiverId,
    DateTime? timeSent,
    bool? isRead,
    MessageType? messageType,
    MessageType? replyMessageType,
    String? replyMessage,
    String? replyTo,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      timeSent: timeSent ?? this.timeSent,
      isRead: isRead ?? this.isRead,
      messageType: messageType ?? this.messageType,
      replyMessageType: replyMessageType ?? this.replyMessageType,
      replyMessage: replyMessage ?? this.replyMessage,
      replyTo: replyTo ?? this.replyTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isRead': isRead,
      'messageType': messageType.type,
      'replyMessageType': replyMessageType.type,
      'replyMessage': replyMessage,
      'replyTo': replyTo,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      content: map['content'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      receiverId: map['receiverId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      isRead: map['isRead'] as bool,
      messageType: (map['messageType'] as String).toEnum(),
      replyMessageType: (map['replyMessageType'] as String).toEnum(),
      replyMessage: map['replyMessage'] as String,
      replyTo: map['replyTo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(messageId: $messageId, content: $content, senderId: $senderId, senderName: $senderName, receiverId: $receiverId, timeSent: $timeSent, isRead: $isRead, messageType: $messageType, replyMessageType: $replyMessageType, replyMessage: $replyMessage, replyTo: $replyTo)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId &&
        other.content == content &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.receiverId == receiverId &&
        other.timeSent == timeSent &&
        other.isRead == isRead &&
        other.messageType == messageType &&
        other.replyMessageType == replyMessageType &&
        other.replyMessage == replyMessage &&
        other.replyTo == replyTo;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        content.hashCode ^
        senderId.hashCode ^
        senderName.hashCode ^
        receiverId.hashCode ^
        timeSent.hashCode ^
        isRead.hashCode ^
        messageType.hashCode ^
        replyMessageType.hashCode ^
        replyMessage.hashCode ^
        replyTo.hashCode;
  }
}

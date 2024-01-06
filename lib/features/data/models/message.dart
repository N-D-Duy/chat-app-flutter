// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String messageId;
  final String chatId;
  final String content;
  final String senderId;
  final String receiverId;
  final String timestamp;
  Message({
    required this.messageId,
    required this.chatId,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });

  Message copyWith({
    String? messageId,
    String? chatId,
    String? content,
    String? senderId,
    String? receiverId,
    String? timestamp,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'chatId': chatId,
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      chatId: map['chatId'] as String,
      content: map['content'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(messageId: $messageId, chatId: $chatId, content: $content, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.messageId == messageId &&
      other.chatId == chatId &&
      other.content == content &&
      other.senderId == senderId &&
      other.receiverId == receiverId &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
      chatId.hashCode ^
      content.hashCode ^
      senderId.hashCode ^
      receiverId.hashCode ^
      timestamp.hashCode;
  }
}

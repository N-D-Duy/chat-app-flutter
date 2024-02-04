import 'package:chat_app_flutter/features/data/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  final List<Message> messages;
  final String uid;
  const MessageItem({super.key, required this.messages, required this.uid});

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  String get uid => widget.uid;
  List<Message> get messages => widget.messages;

  @override
  Widget build(BuildContext context) {
    // Sort messages by timestamp
    if (messages.isNotEmpty) {
      messages.sort((a, b) => a.timeSent.compareTo(b.timeSent));
    }
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageItem(messages[index]);
      },
    );
  }

  Widget _buildMessageItem(Message message) {
    bool isSender = message.senderId == uid;
    if (isSender) {
      return SenderMessageItem(message: message);
    } else {
      return ReceiverMessageItem(message: message);
    }
  }
}

class SenderMessageItem extends StatelessWidget {
  final Message message;
  const SenderMessageItem({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.content),
      subtitle: Text(message.timeSent.toIso8601String()),
    );
  }
}

class ReceiverMessageItem extends StatelessWidget {
  final Message message;

  const ReceiverMessageItem({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.content),
      subtitle: Text(message.timeSent.toIso8601String()),
      // Add additional UI elements for receiver messages, e.g., avatar
    );
  }
}

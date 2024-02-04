/* // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_app_flutter/features/data/models/chat.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;

  const ChatItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              message.length > 30 ? message.substring(0, 30) + '...' : message,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          Text(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          unreadCount.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
 */
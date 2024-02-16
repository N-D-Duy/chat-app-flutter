// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/bottom_chat_field_icon.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/mic/recording_mic.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/components/chat_page_bar.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/components/message_list.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = 'chat_page';
  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;
  const ChatPage({
    Key? key,
    required this.name,
    required this.receiverId,
    required this.profilePicture,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatPageBar(
          name: name,
          receiverId: receiverId,
          profilePicture: profilePicture,
          isGroupChat: isGroupChat,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: MessagesList(
                        receiverId: receiverId, isGroupChat: isGroupChat)),
                BottomChatFieldIcon(
                    receiverId: receiverId, isGroupChat: isGroupChat)
              ],
            ),
            RecordingMic(receiverId: receiverId, isGroupChat: isGroupChat)
          ],
        ));
  }
}

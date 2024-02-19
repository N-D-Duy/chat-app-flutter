import 'package:chat_app_flutter/core/utils/extensions/time_extension.dart';
import 'package:chat_app_flutter/features/domain/models/chat_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_page.dart';
import 'package:chat_app_flutter/features/presentation/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContactsCard extends StatelessWidget {
  final Chat chat;
  const ChatContactsCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream:
      context.read<ChatCubit>().getNumberOfUnreadMessages(chat.contactId),
      builder: (context, snapshot) {
        print('profileUrl: ${chat.profileUrl}');
        return CustomListTile(
          onTap: () {
            Navigator.pushNamed(context, ChatPage.routeName,
                arguments: ChatPage(
                  name: chat.name,
                  receiverId: chat.contactId,
                  profilePicture: chat.profileUrl.trim(),
                  isGroupChat: false,
                ));
          },
          leading: Hero(
            tag: chat.name,
            child: InkWell(
              // onTap: () => showContactProfileDialog(context,chatContactData),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(chat.profileUrl),
                )),
          ),
          title: chat.name,
          subTitle: chat.lastMessage,
          time: chat.lastMessageTime!.getChatContactTime,
          numOfMessageNotSeen: snapshot.data ?? 0,
        );
      },
    );
  }
}
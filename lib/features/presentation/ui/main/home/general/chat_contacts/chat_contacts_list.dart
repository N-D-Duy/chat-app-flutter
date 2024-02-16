import 'package:chat_app_flutter/features/domain/models/chat_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/general/chat_contacts/chat_contacts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContactList extends StatelessWidget {
  const ChatContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
      stream: context.read<ChatCubit>().getAllChatContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return InkWell(
                    onTap: () => {
                          Navigator.pushNamed(context, ChatPage.routeName,
                              arguments: ChatPage(
                                name: chatContactData.name,
                                receiverId: chatContactData.contactId,
                                profilePicture: chatContactData.profileUrl,
                                isGroupChat: false,
                              ))
                        },
                    child: ChatContactsCard(chat: chatContactData));
              },
            );
          } else {
            return const Center(
              child: Text('No contacts'),
            );
          }
        }
      },
    );
  }
}

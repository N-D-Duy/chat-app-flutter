// ignore_for_file: avoid_print

import 'package:chat_app_flutter/core/utils/extensions/time_extension.dart';
import 'package:chat_app_flutter/features/domain/models/group_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_page.dart';
import 'package:chat_app_flutter/features/presentation/widgets/chat_item.dart';
import 'package:chat_app_flutter/features/presentation/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class ChatGroupCard extends StatelessWidget {
  final GroupModel group;
  const ChatGroupCard({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatPage.routeName,
           arguments: ChatPage(
                name: group.name,
                receiverId: group.groupId,
                profilePicture: group.groupProfilePic,
                isGroupChat: true,
            )
        );
      },
      leading: Hero(
        tag: group.name,
        child: InkWell(
            onTap: () => //show something when the image is clicked
                print('show something when the image is clicked'),
            child: CustomImage(
              imageUrl: group.groupProfilePic,
              radius: 30,
            )),
      ),
      title: group.name,
      subTitle: group.lastMessage,
      time: group.timeSent.getChatContactTime,
    );
  }
}

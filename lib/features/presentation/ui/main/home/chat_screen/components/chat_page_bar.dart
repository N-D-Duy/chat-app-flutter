// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_flutter/core/utils/extensions/time_extension.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/others/background_chat/background_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/user/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_flutter/features/presentation/widgets/custom_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/datasources/others/change_background_color.dart';
import '../../../../../bloc/call/call_cubit.dart';

class ChatPageBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;
  final String profilePicture;
  final bool isGroupChat;

  const ChatPageBar({
    Key? key,
    required this.name,
    required this.receiverId,
    required this.profilePicture,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGroupChat) {
      //not available yet
    }

    return StreamBuilder<UserModel>(
        stream: context.read<UserCubit>().getUserById(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey,
              title: const Text("Loading..."),
            );
          }
          UserModel user = snapshot.data!;
          print('user: $user');
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.grey.withOpacity(0.5),
            title: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Stack(
                    children: [
                      CustomImage(
                          imageUrl: profilePicture.isEmpty
                              ? "https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png"
                              : profilePicture,
                          radius: 20),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: user.isOnline ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Text(user.isOnline ? "Online" : user.lastSeen.getLastSeen,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    //not available yet
                  },
                  icon: const Icon(Icons.local_phone_outlined,
                      color: Colors.black)),
              IconButton(
                  onPressed: () {
                    //go to video call
                    context.read<CallCubit>().makeCall(context,
                        receiverId: receiverId,
                        receiverName: name,
                        receiverPic: profilePicture.isNotEmpty
                            ? profilePicture
                            : "https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png",
                        isGroupChat: isGroupChat);
                  },
                  icon:
                      const Icon(Icons.videocam_outlined, color: Colors.black)),
              IconButton(
                onPressed: () => {
                  showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(20, 50, 0, 0),
                      items: [
                        PopupMenuItem(
                            value: 1,
                            onTap: () => _showBackgroundDialog(context),
                            child: const Text("Change Background")),
                      ])
                },
                icon: const Icon(Icons.more_vert_outlined, color: Colors.black),
              ),
            ],
          );
        });
  }

  void _showBackgroundDialog(BuildContext context) {
    List<List<Color>> colors = [
      [
        const Color(0xFF4158D0),
        const Color(0xFFC850C0),
        const Color(0xFFFFCC70)
      ],
      [const Color(0xFF0093E9), const Color(0xFF80D0C7)],
      [const Color(0xFF00DBDE), const Color(0xFFFC00FF)],
      [const Color(0xFFD9AFD9), const Color(0xFF97D9E1)],
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose Background'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      saveBackground(colors[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: colors[index],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      margin: const EdgeInsets.all(8.0),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

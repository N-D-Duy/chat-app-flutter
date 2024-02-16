// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_app_flutter/features/presentation/widgets/custom_avatar.dart';

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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              //not available yet
            },
            icon: const Icon(Icons.local_phone_outlined, color: Colors.black)),
        IconButton(
            onPressed: () {
              //not available yet
            },
            icon: const Icon(Icons.videocam_outlined, color: Colors.black)),
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

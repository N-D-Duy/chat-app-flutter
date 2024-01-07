// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_flutter/features/data/models/message.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_state.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final Profile profile;
  final String uid;
  const ChatScreen({Key? key, required this.profile, required this.uid}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String get senderId => widget.profile.uid;
  String get uid => widget.uid;
  String get name => widget.profile.userName;
  String? get avatar => widget.profile.avatar;

  List<List<Color>> colors = [
    [const Color(0xFF4158D0), const Color(0xFFC850C0), const Color(0xFFFFCC70)],
    [const Color(0xFF0093E9), const Color(0xFF80D0C7)],
    [const Color(0xFF00DBDE), const Color(0xFFFC00FF)],
    [const Color(0xFFD9AFD9), const Color(0xFF97D9E1)],
  ];

  List<Color> currentBackgroundColor = [];
  final FocusNode _inputFocus = FocusNode();
  final TextEditingController _inputController = TextEditingController();
  bool _isTexting = false;

  @override
  Widget build(BuildContext context) {
    String chatId = senderId.compareTo(uid) < 0 ? senderId + uid : uid + senderId;
    BlocProvider.of<ChatCubit>(context).getChatMessages(chatId);
    return Scaffold(
      appBar: _appBarSection(context),
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: currentBackgroundColor.isEmpty
                        ? colors[0]
                        : currentBackgroundColor))),
        BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatLoadedState) {
              List<Message> messages = state.data;
              return MessageItem(messages: messages, uid: senderId);
            }
            return const Center(child: Text('Error'));
          },
        ),
        _inputSection()
      ]),
    );
  }

  PreferredSize _appBarSection(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: LinearGradient(
          colors: currentBackgroundColor.isEmpty
              ? colors[0]
              : currentBackgroundColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).colors[0].withOpacity(0.5),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        title: Row(
          children: [
            SizedBox(
              width: 40,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: (avatar != null)
                        ? AssetImage(avatar!)
                        : const AssetImage('assets/images/default_avatar.jpg'),
                  ),
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
              icon:
                  const Icon(Icons.local_phone_outlined, color: Colors.black)),
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
      ),
    );
  }

  Positioned _inputSection() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          color: LinearGradient(
            colors: currentBackgroundColor.isEmpty
                ? colors[0]
                : currentBackgroundColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).colors[0].withOpacity(0.5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  //not available yet
                },
                icon: const Icon(Icons.add_circle_outline_outlined,
                    color: Colors.black)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  focusNode: _inputFocus,
                  onChanged: (value) {
                    setState(() {
                      _isTexting = value.isNotEmpty;
                      _inputController.text = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: "Type a message",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Container(
              child: _isTexting
                  ? IconButton(
                      onPressed: () {
                        //not available yet
                      },
                      icon:
                          const Icon(Icons.send_outlined, color: Colors.black))
                  : Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              //not available yet
                            },
                            icon: const Icon(Icons.camera_alt_outlined,
                                color: Colors.black)),
                        IconButton(
                            onPressed: () {
                              //not available yet
                            },
                            icon: const Icon(Icons.mic_outlined,
                                color: Colors.black)),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _showBackgroundDialog(BuildContext context) {
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
                    setState(() {
                      currentBackgroundColor = colors[index];
                    });
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
      },
    );
  }
}

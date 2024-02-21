// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/bottom_chat_field_icon.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/mic/recording_mic.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/components/chat_page_bar.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/components/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/others/background_chat/background_cubit.dart';

class ChatPage extends StatefulWidget {
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
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatPageBar(
          name: widget.name,
          receiverId: widget.receiverId,
          profilePicture: widget.profilePicture,
          isGroupChat: widget.isGroupChat,
        ),
        body: Stack(
          children: [
            BlocBuilder<BackgroundCubit, BackgroundState>(
              builder: (context, state) {
                context.watch<BackgroundCubit>().loadBackgroundColor();
                if (state is GetBackgroundSuccess) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: state.gradientColors,
                      ),
                    ),
                  );
                } else if (state is InitialBackground) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: state.defaultBackground,
                      ),
                    ),
                  );
                } else if (state is ChangeBackgroundLoading) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white],
                      ),
                    ),
                  );
                } else if (state is BackgroundError) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white],
                      ),
                    ),
                  );
                }
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white],
                    ),
                  ),
                );
              },
            ),
            Column(
              children: [
                Expanded(
                    child: MessagesList(
                        receiverId: widget.receiverId, isGroupChat: widget.isGroupChat)),
                BottomChatFieldIcon(
                    receiverId: widget.receiverId, isGroupChat: widget.isGroupChat)
              ],
            ),
            RecordingMic(receiverId: widget.receiverId, isGroupChat: widget.isGroupChat)
          ],
        ));
  }
}

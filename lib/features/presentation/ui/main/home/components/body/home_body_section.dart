import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  final String uid;
  const HomeBody({super.key, required this.uid});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String get uid => widget.uid;

  @override
  Widget build(BuildContext context) {
    if (uid.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context).getChats(uid);
    }
    return SizedBox(
      child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 5,
                    width: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                bottom: 0,
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatLoadedState) {
                      List<Chat> list = state.data;
                      if (list.isEmpty) {
                        return const Center(child: Text('No chats found'));
                      } else {
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              Chat chat = list[index];
                              return ListTile(
                                title: Text(chat.chatId),
                              );
                            });
                      }
                    } else if (state is ChatErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          )),
    );
  }
}

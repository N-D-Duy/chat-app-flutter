import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/data/models/message.dart';
import 'package:chat_app_flutter/features/data/models/resource.dart';
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final usecase = di<UseCases>;
  ChatCubit() : super(ChatInitialState());

  Future<void> getChats(String uid) async {
    emit(ChatLoadingState());
    List<Chat> list = [];
    await usecase().chat.getChatsByUid(uid).then((value) => {
          if (value.status == Status.SUCCESS)
            {
              if (value.data != null)
                {
                  list = value.data!.map((e) => Chat.fromMap(e)).toList(),
                  emit(ChatLoadedState(data: list))
                }
              else
                {emit(ChatLoadedState(data: []))}
            }
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }

  Future<void> createChat(String uid1, String uid2, Chat chat) async {
    emit(ChatLoadingState());
    await usecase().chat.insertChat(uid1, uid2, chat).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ChatCreated())}
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    emit(ChatLoadingState());
    await usecase().chat.deleteMessage(chatId, messageId).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ChatDeleted())}
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }

  Future<void> deleteChat(String uid, String chatId) async {
    emit(ChatLoadingState());
    await usecase().chat.deleteChat(uid, chatId).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ChatDeleted())}
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }

  Future<void> getChatMessages(String chatId) async {
    emit(ChatLoadingState());
    List<Message> list = [];
    await usecase().chat.getChatMessages(chatId).then((value) => {
          if (value.status == Status.SUCCESS)
            {
              if (value.data != null)
                {
                  list = value.data!.map((e) => Message.fromMap(e)).toList(),
                  emit(ChatLoadedState(data: list))
                }
              else
                {emit(ChatLoadedState(data: []))}
            }
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }

  Future<void> insertChatMessage(
      String chatId, Map<String, dynamic> message) async {
    emit(ChatLoadingState());
    await usecase().chat.insertChatMessage(chatId, message).then((value) => {
          if (value.status == Status.SUCCESS)
            {emit(ChatCreated())}
          else if (value.status == Status.ERROR)
            {emit(ChatErrorState(message: value.message!))}
        });
  }
}

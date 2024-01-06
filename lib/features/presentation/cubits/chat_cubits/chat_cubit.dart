import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/data/models/chat.dart';
import 'package:chat_app_flutter/features/domain/usecases/use_cases.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final usecase = di<UseCases>;
  ChatCubit() : super(ChatInitialState());

  Future<void> getChats(String uid) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.getChatsByUid(uid);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatLoadedState(chats: data)));
  }

  Future<void> createChat(String uid1, String uid2, Chat chat) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.insertChat(uid1, uid2, chat);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatCreated()));
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.deleteMessage(chatId, messageId);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatDeleted()));
  }

  Future<void> deleteChat(String uid, String chatId) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.deleteChat(uid, chatId);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatDeleted()));
  }

  Future<void> getChatMessages(String chatId) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.getChatMessages(chatId);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatLoadedState(chats: data)));
  }

  Future<void> insertChatMessage(
      String chatId, Map<String, dynamic> message) async {
    emit(ChatLoadingState());
    final result = await usecase().chat.insertChatMessage(chatId, message);
    result.fold((failure) => emit(ChatErrorState(message: failure.message)),
        (data) => emit(ChatUpdated()));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final usecase = di<AppUseCases>;
  ChatCubit() : super(ChatInitialState());

  Stream<ChatState> getAllChatContacts() async* {
    yield ChatLoadingState();

    try {
      final result = usecase().chatContacts.getChatContacts();
      yield GetAllChatContactsSuccess(data: result);
    } catch (error) {
      yield ChatError(message: error.toString());
    }
  }

  Stream<ChatState> getNumberOfUnreadMessages(String senderId) async* {
    yield ChatLoadingState();

    try {
      final result = usecase().chatContacts.getNumOfMessageNotSeen(senderId);
      yield GetNumberOfUnreadMessagesSuccess(data: result);
    } catch (error) {
      yield ChatError(message: error.toString());
    }
  }

  /* Future<void> createChat(String senderId, String receiverId) async {
    emit(ChatLoadingState());

    try {
      await usecase().chat.createChat(senderId, receiverId);
      emit(ChatCreatedSuccess());
    } catch (error) {
      emit(ChatError(message: error.toString()));
    }
  } */

  /* Future<void> deleteChat(String senderId, String receiverId) async {
    emit(ChatLoadingState());

    try {
      await usecase().chat.deleteChat(senderId, receiverId);
      emit(ChatDeletedSuccess());
    } catch (error) {
      emit(ChatError(message: error.toString()));
    }
  } */
}

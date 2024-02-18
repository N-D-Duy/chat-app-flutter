import 'package:chat_app_flutter/features/domain/models/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';

import '../../../../domain/models/message_model.dart';
import '../../../../domain/models/message_reply_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  MessageReplyModel? messageReplay;
  bool isPressed = false;
  int selectedMessageIndex = -1;
  final usecase = di<AppUseCases>;
  ChatCubit() : super(ChatInitialState());

  Stream<List<Chat>> getAllChatContacts() {
    return usecase().chatContacts.getChatContacts();
  }

  Stream<int> getNumberOfUnreadMessages(String senderId) {
    return usecase().chatContacts.getNumOfMessageNotSeen(senderId);
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

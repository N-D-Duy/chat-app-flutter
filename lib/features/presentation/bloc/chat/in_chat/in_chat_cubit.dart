import 'dart:io';

import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/core/utils/enum/message_type.dart';
import 'package:chat_app_flutter/features/data/models/message_model.dart';
import 'package:chat_app_flutter/features/data/models/message_reply_model.dart';
import 'package:chat_app_flutter/features/domain/usecases/app_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'in_chat_state.dart';

class InChatCubit extends Cubit<InChatState> {
  final usecases = di<AppUseCases>;
  bool isPressed = false;
  int selectedMessageIndex = -1;

  InChatCubit() : super(InChatInitialState());

  MessageReplyModel? messageReplay;

  //set messageReplay to null if user click cancel replay
  void cancelReplay() {
    messageReplay = null;
    emit(CancelReplayState());
  }

  //when user swipe it'll insert the value from parameter into messageReplay
  void onMessageSwipe(
      {required String message,
      required bool isMe,
      required MessageType messageType,
      required String repliedTo}) {
    messageReplay = MessageReplyModel(
      message: message,
      isMe: isMe,
      messageType: messageType,
      repliedTo: repliedTo,
    );
    emit(MessageSwipeState());
  }

  Stream<InChatState> getGroupChatStream(String groupId) async* {
    yield InChatLoadingState();
    try {
      final result = usecases().chat.getGroupChatStream(groupId);
      yield GetGroupChatStreamSuccess(data: result);
    } catch (error) {
      yield InChatErrorState(message: error.toString());
    }
  }

  Stream<InChatState> getChatStream(String receiverId) async* {
    yield InChatLoadingState();
    try {
      final result = usecases().chat.getChatStream(receiverId);
      yield GetChatStreamSuccess(data: result);
    } catch (error) {
      yield InChatErrorState(message: error.toString());
    }
  }

  Future<void> sendTextMessage(
      {required String text,
      required String receiverId,
      required bool isGroupChat}) async {
    final result = await usecases().chat.sendTextMessage(
        text: text,
        receiverId: receiverId,
        messageReply: messageReplay,
        isGroupChat: isGroupChat);
    //set messageReplay to null after sending data and it'll make replay preview disappear
    messageReplay = null;
    result.fold(
      (error) => emit(InChatErrorState(message: error.message)),
      (success) => emit(SendTextMessageSuccess()),
    );
  }

  Future<void> sendFileMessage(
      {required File file,
      required String receiverId,
      required MessageType messageType,
      required bool isGroupChat}) async {
    final result = await usecases().chat.sendFileMessage(
        file: file,
        receiverId: receiverId,
        messageType: messageType,
        messageReply: messageReplay,
        isGroupChat: isGroupChat);
    messageReplay = null;
    result.fold(
      (e) => emit(InChatErrorState(message: e.message)),
      (success) => emit(SendFileMessageSuccess()),
    );
  }

  Future<void> sendGIFMessage(
      {required String gifUrl,
      required String receiverId,
      required bool isGroupChat}) async {
    // The function first extracts the unique identifier of the GIF from the gifUrl parameter. It then constructs a new URL for the GIF by
    // replacing giphy.gif with 200.gif, which returns a lower quality version of the GIF but with a smaller file size.
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    final result = await usecases().chat.sendGIFMessage(
        gifUrl: newGifUrl,
        receiverId: receiverId,
        messageReply: messageReplay,
        isGroupChat: isGroupChat);
    messageReplay = null;
    result.fold(
      (error) => emit(InChatErrorState(message: error.message)),
      (success) => emit(SendTextMessageSuccess()),
    );
  }

  Future<void> setMessageSeen(String receiverId, String messageId) async {
    final result = await usecases().chat.setMessageSeen(receiverId, messageId);
    result.fold(
      (l) => emit(InChatErrorState(message: l.message)),
      (r) => emit(MessageReadedSuccess()),
    );
  }

  // Update the value of isPressed
  void updateIsPressed(int selectedIndex, Message message) {
    isPressed = true;
    selectedMessageIndex = selectedIndex;
    emit(MessageSelected()); // Emit a state updated event
  }

  void clearSelectedIndex() {
    isPressed = false;
    selectedMessageIndex = -1; // Clear the selectedIndex value
    emit(SelectedMessageIndexCleared());
  }
}

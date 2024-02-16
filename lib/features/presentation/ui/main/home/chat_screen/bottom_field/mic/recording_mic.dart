import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_app_flutter/core/utils/enum/message_type.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/bottom_field/mic/recording_mic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingMic extends StatefulWidget {
  final String receiverId;
  final bool isGroupChat;

  const RecordingMic(
      {Key? key, required this.receiverId, required this.isGroupChat})
      : super(key: key);

  @override
  State<RecordingMic> createState() => _RecordingMicState();
}

class _RecordingMicState extends State<RecordingMic> {
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !context
          .watch<BottomChatCubit>()
          .isShowSendButton, //visible if isShowSendButton = false
      child: RecordingMicWidget(
        onVerticalScrollComplete: () {},
        onHorizontalScrollComplete: () {
          cancelRecord();
        },
        onLongPress: () {
          startRecording();
        },
        onLongPressCancel: () {
          stopRecording();
        },
        onSend: () {
          stopRecording();
        },
        onTapCancel: () {
          cancelRecord();
        },
      ),
    );
  }

  void startRecording() async {
    if (await recorderController.checkPermission()) {
      await recorderController.record();
    }
  }

  void cancelRecord() async {
    await recorderController.stop();
  }

  //when recording was stop it will send audio to firebase
  void stopRecording() async {
    final path = await recorderController.stop();
    if (!mounted) return;
    context.read<InChatCubit>().sendFileMessage(
        file: File(path!),
        receiverId: widget.receiverId,
        messageType: MessageType.audio,
        isGroupChat: widget.isGroupChat);
  }

  @override
  void dispose() {
    super.dispose();
    recorderController.dispose();
  }
}

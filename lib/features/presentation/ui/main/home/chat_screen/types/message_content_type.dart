import 'package:chat_app_flutter/core/utils/enum/message_type.dart';
import 'package:chat_app_flutter/features/domain/models/message_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/types/audio_message_widget.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/types/text_message_widget.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/types/video_message_widget.dart';
import 'package:flutter/material.dart';

import 'image_message_widget.dart';

class MessageContentType extends StatelessWidget {
  final Message messageData;
  final bool isSender;

  const MessageContentType(
      {Key? key, required this.isSender, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (messageData.messageType) {
      case MessageType.text:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.image:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.video:
        return VideoMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.gif:
        return ImageMessageWidget(messageData: messageData, isSender: isSender);
      case MessageType.audio:
        return AudioMessageWidget(messageData: messageData, isSender: isSender);

      default:
        return TextMessageWidget(messageData: messageData, isSender: isSender);
    }
  }
}

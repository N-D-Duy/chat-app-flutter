import 'package:chat_app_flutter/features/domain/models/message_reply_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/components/reply_message_card.dart';
import 'package:flutter/cupertino.dart';

class ReplyPreview extends StatelessWidget {
  final MessageReplyModel messageReply;
  const ReplyPreview({Key? key, required this.messageReply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      child: ReplyMessageCard(
          showCloseButton: true,
          repliedMessageType: messageReply.messageType,
          text: messageReply.message,
          isMe: messageReply.isMe,
          repliedTo: messageReply.repliedTo),
    );
  }
}

import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/core/utils/extensions/more_extensions.dart';
import 'package:chat_app_flutter/features/domain/models/message_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/types/time_sent_message_widget.dart';
import 'package:flutter/material.dart';

class TextMessageWidget extends StatelessWidget {
  final Message messageData;
  final bool isSender;

  const TextMessageWidget(
      {Key? key, required this.isSender, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            messageData.content,
            style: context.bodyLarge?.copyWith(
                color: isSender ? AppColor.primaryColor : AppColor.grey),
            overflow: TextOverflow.visible,
          ),
        ),
        TimeSentMessageWidget(
            isSender: isSender,
            messageData: messageData,
            colors: isSender ? AppColor.primaryColor : AppColor.grey)
      ],
    );
  }
}

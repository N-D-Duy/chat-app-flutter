import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/features/domain/models/message_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/previews/image_message_preview.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/types/time_sent_message_widget.dart';
import 'package:flutter/material.dart';

class ImageMessageWidget extends StatelessWidget {
  final Message messageData;
  final bool isSender;

  const ImageMessageWidget(
      {Key? key, required this.messageData, required this.isSender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImageMessagePreview.routeName,
            arguments: messageData);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: messageData.content,
                maxHeightDiskCache: 380,
                fit: BoxFit.cover,
                // ignore: prefer_const_constructors
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: TimeSentMessageWidget(
                    isSender: isSender,
                    messageData: messageData,
                    colors: isSender ? AppColor.primaryColor : AppColor.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}

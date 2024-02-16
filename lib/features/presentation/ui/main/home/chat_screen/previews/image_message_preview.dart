import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_flutter/features/domain/models/message_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/previews/app_bar_message_preview.dart';
import 'package:flutter/material.dart';

class ImageMessagePreview extends StatelessWidget {
  static const routeName = "image-message-preview";
  final Message messageData;

  const ImageMessagePreview({Key? key, required this.messageData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBarMessagePreview(messageData: messageData),
        body: Center(
          child: CachedNetworkImage(
              imageUrl: messageData.content,
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator()),
        ));
  }
}

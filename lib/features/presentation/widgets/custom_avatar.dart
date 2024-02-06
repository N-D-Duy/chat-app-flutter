import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  const CustomImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/default_avatar.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

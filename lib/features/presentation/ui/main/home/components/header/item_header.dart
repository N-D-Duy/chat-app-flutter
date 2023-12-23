import 'package:chat_app_flutter/features/presentation/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';

class ItemStatus extends StatelessWidget {
  final String name;
  final String image;
  final bool isSpecialBorder;
  final bool isMyStatus;
  const ItemStatus({super.key, required this.name, required this.image, required this.isSpecialBorder, required this.isMyStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          MyCirlceAvatar(name: name, image: image, isSpecialBorder: true),
        ],
      ),
    );
  }
}

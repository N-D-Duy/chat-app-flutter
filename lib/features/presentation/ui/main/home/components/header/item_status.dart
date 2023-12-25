import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/presentation/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';

class ItemStatus extends StatelessWidget {
  final Profile profile;
  const ItemStatus({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: MyCirlceAvatar(
          name: profile.userName,
          image: profile.avatar,
          isSpecialBorder: true),
    );
  }
}

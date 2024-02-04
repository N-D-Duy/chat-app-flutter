import 'package:chat_app_flutter/features/data/models/profile_model.dart';
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
          name: profile.userName.isEmpty ? 'User' : profile.userName,
          image: (profile.avatar == null)
              ? 'assets/images/default_avatar.jpg'
              : profile.avatar!,
          isSpecialBorder: true),
    );
  }
}

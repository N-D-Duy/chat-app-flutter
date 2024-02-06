import 'package:chat_app_flutter/features/presentation/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';

class ContactsCard extends StatelessWidget {
  final String? image;
  final String name;
  const ContactsCard({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: MyCirlceAvatar(
          name: name.isEmpty ? 'User' : name,
          image: (image == null) ? 'assets/images/default_avatar.jpg' : image!,
          isSpecialBorder: true),
    );
  }
}

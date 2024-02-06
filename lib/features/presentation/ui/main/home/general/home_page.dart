import 'package:chat_app_flutter/features/presentation/ui/main/home/general/bar/home_bar.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/general/chat_contacts/chat_contacts_list.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/general/chat_group/chat_group_list.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/general/contacts/contacts.dart';
import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  static const String routeName = 'home';
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          ContactsList() /* , ChatContactList(), ChatGroupList() */
        ],
      ),
    );
  }
}

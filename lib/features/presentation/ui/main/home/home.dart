import 'package:chat_app_flutter/features/presentation/ui/main/home/components/body/home_body_section.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/components/header/home_header_section.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}

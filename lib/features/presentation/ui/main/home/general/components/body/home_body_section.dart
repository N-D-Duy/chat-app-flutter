import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  final String uid;
  const HomeBody({super.key, required this.uid});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String get uid => widget.uid;

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

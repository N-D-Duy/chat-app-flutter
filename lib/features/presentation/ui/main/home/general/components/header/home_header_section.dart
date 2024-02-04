import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  final String uid;
  const HomeHeader({super.key, required this.uid});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String get uid => widget.uid;
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

import 'package:chat_app_flutter/features/domain/models/status_model.dart';
import 'package:flutter/material.dart';

class StatusList extends StatefulWidget {
  final List<StatusModel> status;
  const StatusList({super.key, required this.status});

  @override
  State<StatusList> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

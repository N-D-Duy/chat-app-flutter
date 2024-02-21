import 'package:chat_app_flutter/features/domain/models/status_model.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/status/components/story_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/user/user_cubit.dart';

class StatusList extends StatelessWidget {
  final List<StatusModel> status;

  const StatusList({super.key, required this.status,});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Số cột
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: status.map((status) {
        final isMyStatus = context.read<UserCubit>().userModel!.userName == status.username;
        return StoryListItem(
          status: status,
          username: status.username,
          isMyStatus: isMyStatus,
        );
      }).toList(),
    );
  }
}


import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/core/utils/extensions/time_extension.dart';
import 'package:chat_app_flutter/features/domain/models/call_model.dart';
import 'package:chat_app_flutter/features/presentation/widgets/custom_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/user/user_cubit.dart';

class CallCard extends StatelessWidget {
  final CallModel callData;

  const CallCard({Key? key, required this.callData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentIdUser = context.read<UserCubit>().userModel!;
    return ListTile(
      onTap: () {},
      leading: CustomImage(
        imageUrl: callData.receiverPic,
        radius: 30,
      ),
      title: Text(
        callData.receiverName,
        style: Theme.of(context).textTheme.headlineSmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          children: [
            currentIdUser.uid == callData.callerId
                ? Icon(Icons.call_made, color: AppColor.green, size: 20)
                : Icon(Icons.call_received, color: AppColor.red, size: 20),
            const SizedBox(width: 5),
            Text(
              callData.timeCalling.getChatContactTime,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(CupertinoIcons.phone_fill, color: AppColor.green),
      ),
    );
  }
}

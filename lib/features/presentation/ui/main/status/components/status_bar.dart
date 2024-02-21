import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/core/utils/extensions/more_extensions.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/status/components/status_privacy_page.dart';
import 'package:chat_app_flutter/features/presentation/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/user_model.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../home/chat_screen/previews/app_bar_message_preview.dart';
import '../../media/camera_page.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        UserModel user = context.read<UserCubit>().userModel!;
        return AppBar(
          backgroundColor: AppColor.primaryColor,
          elevation: 2,
          centerTitle: true,
          leadingWidth: 54,
          leading: IconButton(
            icon: Icon(Icons.camera_alt, color: AppColor.black),
            onPressed: () {
              Navigator.pushNamed(context, CameraPage.routeName, arguments: CameraPage(
                userData: user,
                isGroupChat: false,
              ));
            },
          ),
          title: Text(
            "Stories",
            style: context.titleLarge?.copyWith(color: AppColor.black),
          ),
          actions: [
            PopUp(
              buttons: _buttons(context),
              colors: AppColor.black,
            ),
          ],
        );
      },
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
    PopUpMenuItemModel(
      name: "Status privacy",
      onTap: () {
        Navigator.pushNamed(context, StatusPrivacyPage.routeName);
      },
    ),
    PopUpMenuItemModel(
      name: "Settings",
      onTap: () {},
    ),
  ];


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}



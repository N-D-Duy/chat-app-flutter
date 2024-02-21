import 'package:chat_app_flutter/core/utils/constants/app_color.dart';
import 'package:chat_app_flutter/core/utils/extensions/more_extensions.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/previews/app_bar_message_preview.dart';
import 'package:chat_app_flutter/features/presentation/widgets/pop_up.dart';
import 'package:flutter/material.dart';

class CallAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CallAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      elevation: 2,
      centerTitle: true,
      title: Text(
        "Calls",
        style: context.titleLarge?.copyWith(color: AppColor.black),
      ),
      actions: [
        PopUp(
          buttons: _buttons(context),
          colors: AppColor.black,
        ),
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: "Clear Call Log",
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: "Settings",
          onTap: () {},
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

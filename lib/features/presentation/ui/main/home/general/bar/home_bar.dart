import 'package:chat_app_flutter/core/utils/extensions/more_extensions.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/user/user_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        UserModel? user = context.read<UserCubit>().userModel;
        if (user != null) {
          return AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Messages",
              style: context.titleLarge?.copyWith(color: Colors.black),
            ),
            leadingWidth: 54,
            leading: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: user.uid);
                  },
                  child: Hero(
                      tag: user.uid,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                          radius: 20)),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                onPressed: () {
                  /* Navigator.pushNamed(context, CameraPage.routeName,
                      arguments: CameraPage(
                        userData: user,
                        isGroupChat: false,
                      )); */
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

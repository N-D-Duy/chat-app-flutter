import 'dart:io';

import 'package:chat_app_flutter/core/utils/routes/Approutes.dart';
import 'package:chat_app_flutter/features/domain/models/user_model.dart';
import 'package:chat_app_flutter/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/user/user_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/options/account/account_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/functions/image_griphy_picker.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile';
  final String uid;

  const ProfilePage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        const Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: StreamBuilder<UserModel>(
                stream: context.read<UserCubit>().getUserById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data != null) {
                      var userData = snapshot.data!;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //change avatar
                              _changeAvatar(context);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(userData.profileImage),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(userData.userName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                  }
                })),
        Center(
            child: Container(
          margin: const EdgeInsets.only(top: 320),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ListTile(
                onTap: () => {
                  Navigator.pushNamed(context, AccountDetails.routeName, arguments: uid),
                },
                leading: const Icon(Icons.person),
                title: const Text('Account'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
              ),
              ListTile(
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Log Out'),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).signOut();
                              Navigator.pushReplacementNamed(
                                  context, Login.routeName);
                            },
                            child: const Text('Yes',
                                style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () {
                              // Đóng hộp thoại khi ấn nút "No"
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  )
                },
                leading: const Icon(Icons.logout),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ],
          ),
        ))
      ]),
    );
  }

  Future<void> _changeAvatar(BuildContext context) async {
    //open and pick image from gallery
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploading...'),
          ),
        );
        context.read<UserCubit>().updateProfileImage(image.path);
      }
    }
  }
}

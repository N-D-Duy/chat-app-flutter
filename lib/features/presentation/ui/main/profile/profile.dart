import 'package:chat_app_flutter/core/constants/routes.dart';
import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  @override
  Widget build(BuildContext context) {
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
        const Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_avatar.jpg'),
              ),
              SizedBox(height: 10),
              Text('John Doe',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                'I am a John Doe, I a...',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
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
                  Navigator.pushNamed(context, '/account-details'),
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
                              // Đóng hộp thoại và thực hiện xử lý khi ấn nút "Yes"
                              BlocProvider.of<AuthCubit>(context).signOut();
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.splash);
                              // Thực hiện log out ở đây
                              // ...
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
}

// ignore_for_file: file_names

import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/profile_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case Login.routeName:
        return MaterialPageRoute(builder: (context) => const Login());
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MainScreen());

      case ChatPage.routeName:
        final arguments = settings.arguments as ChatPage;
        return MaterialPageRoute(
            builder: (context) => ChatPage(
                  receiverId: arguments.receiverId,
                  name: arguments.name,
                  profilePicture: arguments.profilePicture,
                  isGroupChat: arguments.isGroupChat,
                ));
      case ProfilePage.routeName:
        // final arguments = settings.arguments as UserModel;
        // return MaterialPageRoute(
        //   builder: (context) => ProfilePage(user: arguments),
        // );
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}

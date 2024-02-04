// ignore: file_names
import 'package:flutter/material.dart';

import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/profile_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case Login.routeName:
        return MaterialPageRoute(builder: (context) => const Login());
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MainScreen());

      case ChatScreen.routeName:
        final arguments = settings.arguments as ChatScreen;
        return MaterialPageRoute(
            builder: (context) => ChatScreen(
                  receiverId: arguments.receiverId,
                  profile: arguments.profile,
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

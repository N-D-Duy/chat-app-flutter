// ignore_for_file: file_names

import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/chat_screen/chat_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/contact_profile_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile_settings/my_profile_page.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../../../features/domain/models/message_model.dart';
import '../../../features/presentation/ui/main/calls/calling/calling_page.dart';
import '../../../features/presentation/ui/main/home/chat_screen/previews/image_message_preview.dart';
import '../../../features/presentation/ui/main/home/chat_screen/previews/video_message_preview.dart';
import '../../../features/presentation/ui/main/home/find_select_contact/find_contact_list.dart';
import '../../../features/presentation/ui/main/home/find_select_contact/search_bar_contact.dart';
import '../../../features/presentation/ui/main/media/camera_page.dart';
import '../../../features/presentation/ui/main/media/widget/preview/image_preview_page.dart';
import '../../../features/presentation/ui/main/media/widget/preview/video_preview_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case Login.routeName:
        return MaterialPageRoute(builder: (context) => const Login());
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case CallingPage.routeName:
        final arguments = settings.arguments as CallingPage;
        return MaterialPageRoute(
          builder: (context) => CallingPage(
              channelId: arguments.channelId,
              call: arguments.call,
              isGroupChat: arguments.isGroupChat
          ),
        );
      case ImageMessagePreview.routeName:
        final arguments = settings.arguments as Message;
        return MaterialPageRoute(
          builder: (context) => ImageMessagePreview(messageData: arguments),
        );
      case VideoMessagePreview.routeName:
        final arguments = settings.arguments as Message;
        return MaterialPageRoute(
          builder: (context) => VideoMessagePreview(messageData: arguments),
        );
      case CameraPage.routeName:
        final arguments = settings.arguments as CameraPage;
        return MaterialPageRoute(
            builder: (context) => CameraPage(
              receiverId: arguments.receiverId,
              userData: arguments.userData,
              isGroupChat: arguments.isGroupChat,
            ));
      case ImagePreviewPage.routeName:
        final arguments = settings.arguments as ImagePreviewPage;
        return MaterialPageRoute(
            builder: (context) => ImagePreviewPage(
              imageFilePath: arguments.imageFilePath,
              receiverId: arguments.receiverId,
              userData: arguments.userData,
              isGroupChat: arguments.isGroupChat,
            ));
      case VideoPreviewPage.routeName:
        final arguments = settings.arguments as VideoPreviewPage;
        return MaterialPageRoute(
            builder: (context) => VideoPreviewPage(
              receiverId: arguments.receiverId,
              videoFilePath: arguments.videoFilePath,
              userData: arguments.userData,
              isGroupChat: arguments.isGroupChat,
            ));
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
        final arguments = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => ProfilePage(
          uid: arguments,
        ));
      case ContactProfilePage.routeName:
        final arguments = settings.arguments as ContactProfilePage;
        return MaterialPageRoute(
            builder: (context) => ContactProfilePage(
                  uid: arguments.uid,
                  name: arguments.name,
                  imageUrl: arguments.imageUrl,
                ));
      case FindContactList.routeName:
        return MaterialPageRoute(builder: (context) => const SearchBarContact());
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }
}

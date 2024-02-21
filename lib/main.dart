import 'package:camera/camera.dart';
import 'package:chat_app_flutter/core/utils/routes/Approutes.dart';
import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/call/call_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_groups/chat_group_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/contacts/contacts_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/others/background_chat/background_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/pages/page_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/status/status_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/user/user_cubit.dart';
import 'package:chat_app_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

import 'features/presentation/ui/main/media/camera_page.dart';

/*const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}*/


Future<void> main() async {
  await initialDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  cameras = await availableCameras();

  /*var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (message) async {
        print('onDidReceiveBackgroundNotificationResponse: $message');
      },
      onDidReceiveNotificationResponse: (message) async {
        print('onDidReceiveNotificationResponse: $message');
      }
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
*/
  runApp(const MainApp());
}

/*Future<void> sendNotification({required String title, required String body, String? payload}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.high,
  );
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  var notificationId = const Uuid().v4();
  // Display the notification
  await flutterLocalNotificationsPlugin.show(
    notificationId.hashCode,
    title,
    body,
    platformChannelSpecifics,
    payload: payload,
  );
}*/





class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => StatusCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ContactsCubit()),
        BlocProvider(create: (context) => ChatGroupCubit()),
        BlocProvider(create: (context) => InChatCubit()),
        BlocProvider(create: (context) => CallCubit()),
        BlocProvider(create: (context) => BottomChatCubit()),
        BlocProvider(create: (context) => BackgroundCubit())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

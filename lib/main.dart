import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_screen.dart';
import 'package:chat_app_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

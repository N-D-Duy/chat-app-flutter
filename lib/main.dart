import 'package:chat_app_flutter/core/constants/routes.dart';
import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/chat_cubits/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/user_cubits/user_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile/account_details.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_screen.dart';
import 'package:chat_app_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await initialDependencies();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.home: (context) => const MainScreen(),
          AppRoutes.accountDetails: (context) => const AccountDetails(),
          AppRoutes.login: (context) => const Login(),
        },
      ),
    );
  }
}

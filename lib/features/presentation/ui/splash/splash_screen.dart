import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_state.dart';
import 'package:chat_app_flutter/features/presentation/ui/login/login.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/main_screen.dart';
import 'package:chat_app_flutter/features/presentation/ui/splash/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AuthCubit>(context).signOut(); // For testing
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedInState) {
            Future.delayed(const Duration(milliseconds: 1000), () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            });
          } else if (state is AuthLoggedOutState) {
            Future.delayed(const Duration(milliseconds: 1000), () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            });
          }
        },
        builder: (context, state) {
          if (state is AuthLoggedInState) {
            Future.delayed(const Duration(milliseconds: 1000), () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            });
          } else if (state is AuthLoggedOutState) {
            Future.delayed(const Duration(milliseconds: 1000), () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            });
          }
          return const SplashBody();
        },
      ),
    );
  }
}

import 'package:chat_app_flutter/core/utils/routes/Approutes.dart';
import 'package:chat_app_flutter/core/di/injection.dart';
import 'package:chat_app_flutter/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/call/call_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/bottom_chat/bottom_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_contacts/chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/chat_groups/chat_group_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/chat/in_chat/in_chat_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/contacts/contacts_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/pages/page_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/profile/profile_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/status/status_cubit.dart';
import 'package:chat_app_flutter/features/presentation/bloc/user/user_cubit.dart';
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
        BlocProvider(create: (context) => StatusCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ContactsCubit()),
        BlocProvider(create: (context) => ChatGroupCubit()),
        BlocProvider(create: (context) => InChatCubit()),
        BlocProvider(create: (context) => CallCubit()),
        BlocProvider(create: (context) => BottomChatCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

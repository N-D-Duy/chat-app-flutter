import 'package:chat_app_flutter/features/presentation/cubits/auth_cubits/auth_cubit.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/components/body/home_body_section.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/components/header/home_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  Future<String> uidFuture = Future.value('');

  @override
  void initState() {
    super.initState();
    uidFuture = _initData();
  }

  Future<String> _initData() async {
    final currentUser =
        await BlocProvider.of<AuthCubit>(context).getCurrentUser();
    return currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FutureBuilder<String>(
                future: uidFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return HomeHeader(uid: snapshot.data!);
                  }
                },
              ),
            ),
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: FutureBuilder<String>(
                future: uidFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return HomeBody(uid: snapshot.data!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

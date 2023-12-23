import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/home/components/header/item_header.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List<User> users = [
    User(true,
        userName: 'My Status',
        avatar: 'assets/images/profile_1.png',
        account: Account(email: 'nguyenducduy@1', password: '123321')),
    User(true,
        userName: 'user 2',
        avatar: 'assets/images/profile_1.png',
        account: Account(email: 'nguyenducduy@2', password: '123321')),
    User(false,
        userName: 'user 3',
        avatar: 'assets/images/profile_1.png',
        account: Account(email: 'nguyenducduy@3', password: '123321')),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Stack(children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search, color: Colors.white, size: 30),
                    Text(
                      'Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/54418563?v=4'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ItemStatus(
                            name: users[index].userName,
                            image: users[index].avatar,
                            isSpecialBorder: users[index].hasSpecialBorder,
                            isMyStatus: true);
                      }),
                ),
              )
            ],
          )
        ]));
  }
}

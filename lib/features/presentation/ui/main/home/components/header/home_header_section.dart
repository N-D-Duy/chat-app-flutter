import 'package:chat_app_flutter/features/data/models/account.dart';
import 'package:chat_app_flutter/features/data/models/profile.dart';
import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List<User> users = [
    User(
        userName: 'My Status',
        account: Account(email: 'nguyenducduy@1', password: '123321'),
        id: '001',
        profile: Profile(
            avatar: 'assets/images/avatar_banana.jpg', userName: 'Duy Nguyen')),
    User(
        userName: 'User1',
        account: Account(email: 'user1@gmail.com', password: '123321'),
        id: '002',
        profile: Profile(
            avatar: 'assets/images/avatar_banana.jpg', userName: 'User1')),
    User(
        userName: 'User2',
        account: Account(email: 'user2@gmail.com', password: '123321'),
        id: '002',
        profile: Profile(
            avatar: 'assets/images/avatar_banana.jpg', userName: 'User2')),
    User(
      userName: 'User3',
      account: Account(email: 'user3@gmail.com', password: '123321'),
      id: '003',
      profile: Profile(
        avatar: 'assets/images/avatar_banana.jpg',
        userName: 'User3',
      ),
    ),
    User(
      userName: 'User4',
      account: Account(email: 'user4@gmail.com', password: '123321'),
      id: '004',
      profile: Profile(
        avatar: 'assets/images/avatar_banana.jpg',
        userName: 'User4',
      ),
    ),
    User(
      userName: 'User5',
      account: Account(email: 'user5@gmail.com', password: '123321'),
      id: '005',
      profile: Profile(
        avatar: 'assets/images/avatar_banana.jpg',
        userName: 'User5',
      ),
    ),
    User(
      userName: 'User6',
      account: Account(email: 'user6@gmail.com', password: '123321'),
      id: '006',
      profile: Profile(
        avatar: 'assets/images/avatar_banana.jpg',
        userName: 'User6',
      ),
    ),
    User(
      userName: 'User7',
      account: Account(email: 'user7@gmail.com', password: '123321'),
      id: '007',
      profile: Profile(
        avatar: 'assets/images/avatar_banana.jpg',
        userName: 'User7',
      ),
    ),
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
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
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
          ),
          Positioned(
            bottom: 30,
            left: 10,
            right: 0,
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      users.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: index == 0
                                ? Column(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  users[index].profile!.avatar),
                                            ),
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.green,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        users[index].profile!.userName,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                              users[index].profile!.avatar),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        users[index].profile!.userName,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                          )),
                ),
              ),
            ),
          )
        ]));
  }
}

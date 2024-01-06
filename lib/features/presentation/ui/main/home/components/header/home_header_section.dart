/* import 'package:chat_app_flutter/features/data/models/user.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List<User> users = [User(userName: 'My Status', uid: '001', chats: [])];

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
 */
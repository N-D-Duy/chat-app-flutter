import 'package:chat_app_flutter/features/presentation/ui/main/home/home.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/notification/notification.dart';
import 'package:chat_app_flutter/features/presentation/ui/main/profile/profile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(bottomNavigationBar: BottomNavigation());
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Widget> pages = <Widget>[
    const HomePages(),
    const NotificationPages(),
    const ProfilePages()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        pages.elementAt(_selectedIndex),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: BottomNavigationBar(
                    elevation: 0.5,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    onTap: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.notifications),
                          label: 'Notification'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: 'Profile'),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: const Color(0xff11DCE8),
                    unselectedItemColor: Colors.grey[600],
                    showUnselectedLabels: false,
                  ))),
        )
      ],
    ));
  }
}

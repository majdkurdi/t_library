import 'package:flutter/material.dart';

import './home_screen.dart';
import './library_screen.dart';
import './notifications_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  Widget getBody() {
    return IndexedStack(
        index: currentIndex,
        children: [HomeScreen(), LibraryScreen(), NotificationsScreen()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getBody(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white.withOpacity(0.4),
                    // showSelectedLabels: false,
                    // showUnselectedLabels: false,
                    onTap: (i) {
                      setState(() => currentIndex = i);
                    },
                    elevation: 0,
                    currentIndex: currentIndex,
                    selectedItemColor: Colors.black,
                    items: [
                      BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                          label: 'My Library',
                          icon: Icon(Icons.list_alt),
                          activeIcon: Icon(Icons.list_alt)),
                      BottomNavigationBarItem(
                          label: 'Notifications',
                          icon: Icon(Icons.notifications_none),
                          activeIcon: Icon(Icons.notifications)),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

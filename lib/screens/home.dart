import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/routes.dart';
import 'package:yathaarth/screens/home/index.dart';
import 'package:yathaarth/screens/home/notifications.dart';
import 'package:yathaarth/screens/home/profile.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeIndex(),
      Notifications(),
      Profile()
    ];
    return Scaffold(
      body: SafeArea(
        child: _children[_currentIndex]
      ),
      bottomNavigationBar: _bottomNavigationBar
    );
  }

  Widget get _bottomNavigationBar {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      iconSize: 22,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).accentColor,
      selectedIconTheme: IconThemeData(color: Theme.of(context).accentColor),
      unselectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Container(height: 0,)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Container(height: 0,)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Container(height: 0,)
        ),
      ],
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
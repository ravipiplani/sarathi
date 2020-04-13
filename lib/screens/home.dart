import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/screens/home/beats.dart';
import 'package:yathaarth/screens/home/customers.dart';
import 'package:yathaarth/screens/home/index.dart';
import 'package:yathaarth/screens/home/orders.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeIndex(),
      Beats(),
      Customers(),
      Orders()
    ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {}
          )
        ],
        title: Text('Yathaarth'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Ravi Piplani'),
              accountEmail: Text('7042401008'),
              currentAccountPicture: CircleAvatar(
                child: Text('RP'),
                backgroundColor: Theme.of(context).primaryColorLight
              ),
            ),
            ListTile(
              title: Text('Support'),
              leading: Icon(Icons.help_outline),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Keys.navigatorKey.currentState.pushNamed(Router.newCustomerRoute);
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
      body: SafeArea(
        child: _children[_currentIndex]
      ),
      bottomNavigationBar: _bottomNavigationBar
    );
  }

  Widget get _bottomNavigationBar {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        onTap: _onTabTapped,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Theme.of(context).accentColor,
        selectedIconTheme: IconThemeData(color: Theme.of(context).accentColor),
        unselectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Beats')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Customers')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Orders')
          ),
        ],
      )
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
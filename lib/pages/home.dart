import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/pages/home/beats.dart';
import 'package:yathaarth/pages/home/customers.dart';
import 'package:yathaarth/pages/home/index.dart';
import 'package:yathaarth/pages/home/orders.dart';

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
    final List<Widget> _children = [HomeIndex(), Beats(), Customers(), Orders()];
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications), onPressed: () {})
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
                currentAccountPicture: CircleAvatar(child: Text('RP'), backgroundColor: Theme.of(context).primaryColorLight),
              ),
              ListTile(
                title: Text('Support'),
                leading: Icon(Icons.help_outline),
              )
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          visible: true,
          closeManually: false,
          child: Icon(Icons.add),
          curve: Curves.bounceIn,
          onOpen: () => {},
          onClose: () => {},
          tooltip: 'Home Options',
          heroTag: 'home-options-hero-tag',
          children: [
            SpeedDialChild(
                child: Icon(Icons.bubble_chart),
                label: 'Create Order',
                onTap: () {
                  Keys.navigatorKey.currentState.pushNamed(Router.newOrderRoute);
                }),
            SpeedDialChild(
                child: Icon(Icons.person_add),
                label: 'Add Customer',
                onTap: () {
                  Keys.navigatorKey.currentState.pushNamed(Router.newCustomerRoute);
                }),
            SpeedDialChild(
                child: Icon(Icons.map),
                label: 'New Beat',
                onTap: () {
                  Keys.navigatorKey.currentState.pushNamed(Router.newBeatRoute);
                }),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        extendBody: true,
        body: SafeArea(child: _children[_currentIndex]),
        bottomNavigationBar: _bottomNavigationBar);
  }

  Widget get _bottomNavigationBar {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Beats')),
            BottomNavigationBarItem(icon: Icon(Icons.group), title: Text('Customers')),
            BottomNavigationBarItem(icon: Icon(Icons.bubble_chart), title: Text('Orders')),
          ],
        ));
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

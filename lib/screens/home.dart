import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_boilerplate/actions/auth_actions.dart';
import 'package:login_boilerplate/models/app_state.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(LogOut());
          },
          builder: (BuildContext context, VoidCallback callback) {
            return RaisedButton(
              onPressed: callback,
              child: Text('Log Out'),
            );
          },
        )
      )
    );
  }
}
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_boilerplate/keys.dart';
import 'package:login_boilerplate/models/app_state.dart';
import 'package:login_boilerplate/routes.dart';
import 'package:login_boilerplate/screens/auth.dart';
import 'package:login_boilerplate/screens/home.dart';
import 'package:login_boilerplate/screens/otp.dart';
import 'package:redux/redux.dart';

class AppRoot extends StatefulWidget {
  final Store<AppState> store;

  AppRoot({Key key, this.store}) : super(key: key);

  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    // store state
    // print(widget.store.state);
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: "Login Boilerplate",
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: Keys.navigatorKey,
        initialRoute: Routes.authScreen,
        routes: {
          Routes.authScreen: (BuildContext context) => Auth(),
          Routes.otpScreen: (BuildContext context) => Otp(),
          Routes.homeScreen: (BuildContext context) => Home(),
        },
      ),
    );
  }
}
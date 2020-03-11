import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/app_state.dart';
import 'package:yathaarth/routes.dart';
import 'package:yathaarth/screens/auth.dart';
import 'package:yathaarth/screens/home.dart';
import 'package:yathaarth/screens/otp.dart';
import 'package:redux/redux.dart';
import 'package:yathaarth/screens/splash.dart';
import 'package:yathaarth/screens/types/create.dart';
import 'package:yathaarth/screens/types/index.dart';
import 'package:yathaarth/screens/types/show.dart';

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
     print(widget.store.state);
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Yathaarth",
        theme: _themeData,
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: Keys.navigatorKey,
        home: Splash(isAuthenticated: widget.store.state.authState.isAuthenticated),
        // initialRoute: Routes.homeScreen,
        routes: {
          Routes.authScreen: (BuildContext context) => Auth(),
          Routes.otpScreen: (BuildContext context) => Otp(),
          Routes.homeScreen: (BuildContext context) => Home(),
          Routes.typesScreen: (BuildContext context) => Types(),
          Routes.newTypeScreen: (BuildContext context) => NewType(),
          Routes.showTypeScreen: (BuildContext context) => ShowType()
        },
      ),
    );
  }

  int primaryColor = 0xFF250F34;
  int accentColor = 0xFFF2BC3A;
  ThemeData get _themeData => ThemeData(
    primaryColor: Color(primaryColor),
    accentColor: Color(accentColor),
    textTheme: TextTheme(
      display3: TextStyle(fontFamily: 'Sofia', color: Color(primaryColor))
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.grey,
      )
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(accentColor),
      textTheme: ButtonTextTheme.primary
    )
  );
}
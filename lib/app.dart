import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/router.dart';

class AppRoot extends StatefulWidget {
  AppRoot({Key key}) : super(key: key);

  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Yathaarth",
      theme: _themeData,
      navigatorObservers: <NavigatorObserver>[observer],
      navigatorKey: Keys.navigatorKey,
      initialRoute: Router.landingRoute,
      onGenerateRoute: generateRoute,
    );
  }

  int primaryColor = 0xFF250F34;
  int accentColor = 0xFFF2BC3A;
  ThemeData get _themeData => ThemeData(
    primaryColor: Color(primaryColor),
    accentColor: Color(accentColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12))
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(accentColor),
      textTheme: ButtonTextTheme.primary
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: Color(accentColor)
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(accentColor)
    )
  );
}
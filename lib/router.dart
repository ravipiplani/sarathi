import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/screens/auth.dart';
import 'package:yathaarth/screens/home.dart';
import 'package:yathaarth/screens/landing.dart';
import 'package:yathaarth/screens/otp.dart';
import 'package:yathaarth/screens/types/create.dart';
import 'package:yathaarth/screens/types/index.dart';
import 'package:yathaarth/screens/types/show.dart';

class Router {
  static const String landingRoute = "/";
  static const String homeRoute = "/home";
  static const String authRoute = "/auth";
  static const String otpRoute = "/auth/otp";
  static const String typesRoute = "/types";
  static const String newTypeRoute = "/types/new";
  static const String showTypeRoute = "/type/show";
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Router.landingRoute:
      return _getPageRoute(Landing(), settings);
      break;
    case Router.homeRoute:
      return _getPageRoute(Home(), settings);
      break;
    case Router.authRoute:
      return _getPageRoute(Auth(), settings);
    case Router.otpRoute:
      OtpArguments args = settings.arguments as OtpArguments;
      return _getPageRoute(Otp(verificationId: args.verificationId, mobile: args.mobile), settings);
    case Router.typesRoute:
      return _getPageRoute(Types(), settings);
    case Router.newTypeRoute:
      return _getPageRoute(NewType(), settings);
    case Router.showTypeRoute:
      return _getPageRoute(ShowType(), settings);
      break;
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ));
      break;
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => child, settings: RouteSettings(name: settings.name));
}
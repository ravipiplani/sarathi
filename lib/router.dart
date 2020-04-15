import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/screens/auth.dart';
import 'package:yathaarth/screens/beats/create.dart';
import 'package:yathaarth/screens/customers/create.dart';
import 'package:yathaarth/screens/customers/show.dart';
import 'package:yathaarth/screens/home.dart';
import 'package:yathaarth/screens/home/customers.dart';
import 'package:yathaarth/screens/landing.dart';
import 'package:yathaarth/screens/orders/create.dart';
import 'package:yathaarth/screens/otp.dart';

class Router {
  static const String landingRoute = "/";
  static const String homeRoute = "/home";
  static const String authRoute = "/auth";
  static const String otpRoute = "/auth/otp";
  static const String customersRoute = "/customers";
  static const String newCustomerRoute = "/customers/new";
  static const String showCustomerRoute = "/customers/show";
  static const String newBeatRoute = "/beats/new";
  static const String newOrderRoute = "/orders/new";
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
      break;
    case Router.otpRoute:
      OtpArguments args = settings.arguments as OtpArguments;
      return _getPageRoute(Otp(verificationId: args.verificationId, mobile: args.mobile), settings);
      break;
    case Router.customersRoute:
      return _getPageRoute(Customers(), settings);
      break;
    case Router.newCustomerRoute:
      return _getPageRoute(NewCustomer(), settings);
      break;
    case Router.showCustomerRoute:
      CustomerArguments customerArguments = settings.arguments as CustomerArguments;
      return _getPageRoute(Customer(establishmentId: customerArguments.establishmentId), settings);
      break;
    case Router.newBeatRoute:
      return _getPageRoute(NewBeat(), settings);
      break;
    case Router.newOrderRoute:
      return _getPageRoute(NewOrder(), settings);
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
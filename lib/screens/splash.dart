import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/routes.dart';

class Splash extends StatefulWidget {
  final bool isAuthenticated;
  Splash({Key key, this.isAuthenticated}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      if (widget.isAuthenticated) {
        Keys.navigatorKey.currentState.pushReplacementNamed(Routes.homeScreen);
      }
      else {
        Keys.navigatorKey.currentState.pushReplacementNamed(Routes.authScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/img/icon.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Container(
                        height: 30,
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/img/logo-2.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Text("Yathaarth", style: Theme.of(context).textTheme.display3,)
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator()
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
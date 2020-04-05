import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/router.dart';

class Landing extends StatelessWidget {
  final bool isAuthenticated;
  Landing({Key key, this.isAuthenticated}) : super(key: key);

  Future<bool> checkIfAuthenticated() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    checkIfAuthenticated().then((bool isAuthenticated) {
       if (isAuthenticated) {
         Keys.navigatorKey.currentState.pushReplacementNamed(Router.homeRoute);
       } else {
         Keys.navigatorKey.currentState.pushReplacementNamed(Router.authRoute);
       }
    });

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
                        child: Text("Yathaarth", style: Theme.of(context).textTheme.headline2,)
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
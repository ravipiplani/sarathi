import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/components/filled_input.dart';
import 'package:yathaarth/components/stat_square.dart';
import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/models/responses/home_response.dart';
import 'package:yathaarth/services/home_service.dart';

class HomeIndex extends StatefulWidget {
  HomeIndex({Key key}) : super(key: key);

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(40),
            child: Align(
              alignment: Alignment.center,
              child: Text("Yathaarth", style: Theme.of(context).textTheme.headline2)
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: FilledInput(hintText: "Search")
          ),
          FutureBuilder<List<HomeResponse>>(
            future: getHomeData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                ? createHomeGrid(snapshot.data)
                : Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator()
                );
            },
          )
        ],
      )
    );
  }

  Widget createHomeGrid(List<HomeResponse> data) {
    return GridView.count(
      padding: EdgeInsets.all(32),
      crossAxisCount: 2,
      crossAxisSpacing: 32,
      mainAxisSpacing: 32,
      shrinkWrap: true,
      primary: true,
      children: data.map((e) => StatSquare(type: e)).toList(),
    );
  }
}

Future<List<HomeResponse>> getHomeData() async {
  final HomeService _homeService = HomeService();
  final List<HomeResponse> response = await _homeService.getHomeData();
  return response;
}
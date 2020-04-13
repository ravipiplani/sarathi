import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/components/search.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/responses/home/home_response.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/services/home_service.dart';

class HomeIndex extends StatefulWidget {
  HomeIndex({Key key}) : super(key: key);

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  Map _stats = {
    'customers': {'icon': Icons.group, 'label': 'Customers'},
    'beats': {'icon': Icons.map, 'label': 'Beats'},
    'orders': {'icon': Icons.list, 'label': 'Orders'}
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Search(),
              Card(
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(Icons.mode_comment),
                  title: Text('Quote of the day'),
                  subtitle: Text(
                    'Great things are not done by one person. They are done by a group of people.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              FutureBuilder<HomeResponse>(
                  future: getDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      HomeResponse _hr = snapshot.data;
                      return Card(
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: _stats.entries.map((e) => InkWell(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[Icon(e.value['icon']), SizedBox(height: 5), Text('${_hr.stats[e.key]} ${e.value['label']}')],
                                  ),
                                  onTap: () {
                                    Keys.navigatorKey.currentState.pushNamed(Router.customersRoute);
                                  },
                                )).toList(),
                              )));
                    }
                    return CircularProgressIndicator();
                  })
            ],
          )),
    );
  }
}

Future<HomeResponse> getDetails() async {
  HomeService _hs = HomeService();
  HomeResponse hr = await _hs.getHomeData();
  return hr;
}

import 'package:flutter/material.dart';
import 'package:yathaarth/components/filled_input.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/routes.dart';
import 'package:yathaarth/screens/types/index.dart';

class HomeIndex extends StatefulWidget {
  HomeIndex({Key key}) : super(key: key);

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final List<Map<String, dynamic>> _types = [
    {
      "label": "SUPER STOCKIST",
      "color": Color(0xFFF16A70),
    },
    {
      "label": "DISTRIBUTORS",
      "color": Color(0xFFB1D877)
    },
    {
      "label": "BEATS",
      "color": Color(0xFF8CDCDA)
    },
    {
      "label": "RETAIL OUTLETS",
      "color": Color(0xFF4D4D4D)
    }
  ];
  
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
              child: Text("Yathaarth", style: Theme.of(context).textTheme.display3)
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: FilledInput(hintText: "Search")
          ),
          GridView.count(
            padding: EdgeInsets.all(32),
            crossAxisCount: 2,
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            shrinkWrap: true,
            primary: true,
            children: List.generate(_types.length, (index) {
              return InkWell(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _types[index]["color"],
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("0", 
                          style: Theme.of(context).textTheme.headline.copyWith(
                            color: Colors.white
                          )
                        )
                      ),
                      Text(_types[index]["label"],
                        style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
                onTap: () {
                  Keys.navigatorKey.currentState.pushNamed(Routes.typesScreen, arguments: TypesArguments(type: _types[index]));
                },
              );
            }),
          )
        ],
      )
    );
  }
}
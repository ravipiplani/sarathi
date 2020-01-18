import 'package:flutter/material.dart';
import 'package:yathaarth/components/filled_input.dart';
import 'package:yathaarth/components/list_item.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/routes.dart';

class TypesArguments {
  final Map<String, dynamic> type;

  TypesArguments({this.type});
}

class Types extends StatefulWidget {
  Types({Key key}) : super(key: key);

  @override
  _TypesState createState() => _TypesState();
}

class _TypesState extends State<Types> {
  @override
  Widget build(BuildContext context) {
    final TypesArguments args = ModalRoute.of(context).settings.arguments;
    final Map<String, dynamic> _type = args.type;
    return Scaffold(
      appBar: AppBar(
        title: Text(_type["label"]),
        backgroundColor: _type["color"],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, right: 32, left: 32),
            child: FilledInput(hintText: "Search"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Keys.navigatorKey.currentState.pushNamed(Routes.showTypeScreen);
                  },
                  child: ListItem()
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Keys.navigatorKey.currentState.pushNamed(Routes.newTypeScreen);
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
        foregroundColor: Colors.white,
        backgroundColor: _type["color"],
      ),
    );
  }
}
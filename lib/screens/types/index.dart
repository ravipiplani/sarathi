import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/components/filled_input.dart';
import 'package:yathaarth/components/list_item.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/models/establishment.dart';
import 'package:yathaarth/routes.dart';
import 'package:yathaarth/screens/types/show.dart';
import 'package:yathaarth/services/establishment_service.dart';

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
  Map<String, dynamic> _type;

  @override
  Widget build(BuildContext context) {
    final TypesArguments args = ModalRoute.of(context).settings.arguments;
    _type = args.type;
    return Scaffold(
      appBar: AppBar(
        title: Text(_type["label"]),
        backgroundColor: Color(int.parse(_type["color"])),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, right: 32, left: 32),
            child: FilledInput(hintText: "Search"),
          ),
          FutureBuilder<List<Establishment>>(
            future: fetchEstablishments(_type),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                ? Expanded(
                  child: _createList(snapshot.data),
                )
                : Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator()
                );
            },
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
        backgroundColor: Color(int.parse(_type["color"])),
      ),
    );
  }

  Widget _createList(List<Establishment> data) {
    if (data.length == 0) {
      return Container(
        padding: EdgeInsets.only(top: 10),
        child: Text('No Data Found!')
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Keys.navigatorKey.currentState.pushNamed(Routes.showTypeScreen, arguments: ShowTypeArguments(establishmentId: data[index].id));
          },
          child: ListItem(title: data[index].name, desc: data[index].mobile, subTitle: "Rs 1")
        );
      },
    );
  }
}

Future<List<Establishment>> fetchEstablishments(Map type) async {
    EstablishmentService _establishmentService = EstablishmentService();
    ApiResponse response = await _establishmentService.index(type: type['label']);
    return compute(parseEstablishments, response.data);
}

List<Establishment> parseEstablishments(dynamic responseBody) {
  final parsed = responseBody.cast<Map<String, dynamic>>();
  return parsed.map<Establishment>((json) => Establishment.fromJson(json)).toList();
}
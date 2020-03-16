import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yathaarth/components/list_item.dart';
import 'package:yathaarth/components/product_counter.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/models/establishment.dart';
import 'package:yathaarth/screens/types/type_header.dart';
import 'package:yathaarth/services/establishment_service.dart';

class ShowTypeArguments {
  final int establishmentId;

  ShowTypeArguments({this.establishmentId});
}

class ShowType extends StatefulWidget {
  ShowType({Key key}) : super(key: key);

  @override
  _ShowTypeState createState() => _ShowTypeState();
}

class _ShowTypeState extends State<ShowType> {
  int _establishmentId;
  final List<Map> _products = [
    {
      "label": "CLEB",
      "price": "10"
    },
    {
      "label": "CCEB",
      "price": "10"
    },
    {
      "label": "KHMF",
      "price": "10"
    },
    {
      "label": "CTMF",
      "price": "10"
    },
    {
      "label": "SBMF",
      "price": "10"
    },
    {
      "label": "ORMF",
      "price": "10"
    },
    {
      "label": "Nut Lite",
      "price": "10"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final ShowTypeArguments args = ModalRoute.of(context).settings.arguments;
    _establishmentId = args.establishmentId;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<Establishment>(
          future: fetchEstablishment(_establishmentId),
          builder: (context, snapshot) {
            Widget header;
            if(snapshot.hasData) {
              header = SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: TypeHeader(
                    minExtent: 138,
                    maxExtent: 257,
                    establishment: snapshot.data
                ),
              );
            } else {
              header = SliverToBoxAdapter(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: <Widget>[
                header,
                SliverPadding(
                  padding: EdgeInsets.only(top: 10),
                ),
                SliverFixedExtentList(
                  itemExtent: 90,
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return ListItem(title: "Test", desc: "Test desc", subTitle: "Rs 1");
                    },
                  ),
                )
              ],
            );
          },
        )
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually 
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => {},
        onClose: () => {},
        tooltip: 'Retailer Options',
        heroTag: 'retailer-options-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Color(0xFFF16A70),
            foregroundColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.caption.copyWith(backgroundColor: Colors.white),
            label: 'Create Order',
            onTap: () {
              _showCreateOrderBottomSheet(context);
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.donut_large),
            backgroundColor: Color(0xFF8CDCDA),
            foregroundColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.caption.copyWith(backgroundColor: Colors.white),
            label: 'Sample',
            onTap: () {
              _showCreateOrderBottomSheet(context);
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.inbox),
            backgroundColor: Color(0xFFB1D877),
            foregroundColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.caption.copyWith(backgroundColor: Colors.white),
            label: 'Stock',
            onTap: () {
              _showCreateOrderBottomSheet(context);
            }
          ),
        ],
      )
    );
  }

  _showCreateOrderBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Stock", style: Theme.of(context).textTheme.title)
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      Map item = _products[index];
                      String label = [item["label"], '@', item["price"]].join("");
                      return ProductCounter(
                        label: label,
                        count: "0",
                      );
                    },
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    child: Text("Save"),
                    onPressed: () {
                      Keys.navigatorKey.currentState.pop();
                    },
                  )
                )
              ],
            ),
          )
        );
      },
      backgroundColor: Colors.transparent
    );
  }
}

Future<Establishment> fetchEstablishment(int id) async {
  EstablishmentService _establishmentService = EstablishmentService();
  ApiResponse response = await _establishmentService.show(id: id);
  return compute(parseEstablishment, response.data);
}

Establishment parseEstablishment(dynamic responseBody) {
  return Establishment.fromJson(responseBody);
}
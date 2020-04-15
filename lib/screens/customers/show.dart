import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yathaarth/components/product_counter.dart';
import 'package:yathaarth/components/product_item.dart';
import 'package:yathaarth/constants/Constants.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/establishment.dart';
import 'package:yathaarth/services/establishment_service.dart';

class CustomerArguments {
  final int establishmentId;

  CustomerArguments({this.establishmentId});
}

class Customer extends StatefulWidget {
  Customer({Key key, this.establishmentId}) : super(key: key);

  final int establishmentId;

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final List<Map> _products = [
    {"label": "CLEB", "price": "10"},
    {"label": "CCEB", "price": "10"},
    {"label": "KHMF", "price": "10"},
    {"label": "CTMF", "price": "10"},
    {"label": "SBMF", "price": "10"},
    {"label": "ORMF", "price": "10"},
    {"label": "Nut Lite", "price": "10"}
  ];

  String customerName;

  @override
  void initState() {
    customerName = 'Customer';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(customerName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.inbox),
              onPressed: () {
                _showStock();
              },
            )
          ],
        ),
        body: FutureBuilder<Establishment>(
          future: fetchEstablishment(widget.establishmentId),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(Constants.kPadding32),
                  color: Colors.red,
                  child: Container(
                    padding: EdgeInsets.all(Constants.kPadding32),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: List<Widget>.generate(10, (index) {
                      return ListTile(title: Text('Test'), subtitle: Text('Test Desc'), trailing: Text('Rs 1'), onTap: () {});
                    }).toList(),
                  ),
                )
              ],
            );
          },
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
                }),
            SpeedDialChild(
                child: Icon(Icons.donut_large),
                backgroundColor: Color(0xFF8CDCDA),
                foregroundColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.caption.copyWith(backgroundColor: Colors.white),
                label: 'Sample',
                onTap: () {
                  _showCreateOrderBottomSheet(context);
                }),
            SpeedDialChild(
                child: Icon(Icons.inbox),
                backgroundColor: Color(0xFFB1D877),
                foregroundColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.caption.copyWith(backgroundColor: Colors.white),
                label: 'Stock',
                onTap: () {
                  _showCreateOrderBottomSheet(context);
                }),
          ],
        ));
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
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 10), child: Text("Stock", style: Theme.of(context).textTheme.headline6)),
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
                    )),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          child: Text("Save"),
                          onPressed: () {
                            Keys.navigatorKey.currentState.pop();
                          },
                        ))
                  ],
                ),
              ));
        },
        backgroundColor: Colors.transparent);
  }

  _showStock() {
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
                        child: Text("Current Stock", style: Theme.of(context).textTheme.headline6)
                    ),
                    Expanded(
                        child: ListView.builder(
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            Map item = _products[index];
                            String label = [item["label"], '@', item["price"]].join("");
                            return ProductItem(
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
                          child: Text("Close"),
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
  Establishment establishment = await _establishmentService.show(id: id);
  print(establishment);
  return establishment;
}

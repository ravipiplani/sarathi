import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sarathi/models/product.dart';
import 'package:sarathi/data/products.dart';
import 'package:sarathi/theme.dart';
import 'package:sarathi/widgets/product_counter.dart';

class NewOrder extends StatefulWidget {
  NewOrder({Key key}) : super(key: key);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  String _selectedCustomer;
  List<Product> _products;

  @override
  void initState() {
    _products = Products.all();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, label: Text('Create'), icon: Icon(Icons.done)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(SarathiTheme.kPadding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: SarathiTheme.kPadding16),
                child: Icon(Icons.bubble_chart)
              ),
              SearchableDropdown(
                isExpanded: true,
                isCaseSensitiveSearch: false,
                value: _selectedCustomer,
                hint: Text('Select Customer', style: Theme.of(context).inputDecorationTheme.hintStyle),
                label: Text('Customer', style: Theme.of(context).inputDecorationTheme.labelStyle),
                items: List<DropdownMenuItem>.generate(10, (index) => DropdownMenuItem(
                  value: 'Item $index',
                  child: Text('Item $index'),
                )),
                onChanged: (value) {
                  setState(() {
                    _selectedCustomer = value;
                  });
                },
                underline: Container(
                  height: 1.0,
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(width: 1.0))),
                ),
              ),
              SizedBox(height: SarathiTheme.kPadding16),
              ...
              _products.map((e) => ProductCounter(
                label: e.name,
                count: "0",
              )).toList()
            ],
          ),
        ),
      ),
    );
  }
}
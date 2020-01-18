import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yathaarth/components/heading.dart';
import 'package:yathaarth/components/product_item.dart';
import 'package:yathaarth/keys.dart';

class TypeHeader implements SliverPersistentHeaderDelegate{
  final double minExtent;
  final double maxExtent;

  TypeHeader({
    @required this.minExtent,
    @required this.maxExtent
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Keys.navigatorKey.currentState.pop();
                    }
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Heading(
                        text: "Punjab Ditributor",
                        size: 32,
                      ),
                      Chip(
                        label: Text("Retailer", style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor),),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    ],
                  )
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.inbox, color: Theme.of(context).accentColor,),
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      _showStock(context);
                    },
                  ),
                )
              ],
            )
          ),
          Transform.scale(
            scale: 1.0 - max(0.0, shrinkOffset) / maxExtent,
            child: Opacity(
              opacity: 1.0 - max(0.0, shrinkOffset) / maxExtent,
              child: Column(
                children: <Widget>[
                  shrinkOffset > 95.0 ? Container() : Text("Ravi Piplani", style: Theme.of(context).textTheme.title,),
                  shrinkOffset > 50.0 ? Container() : Text("7042401008", style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor)),
                  shrinkOffset > 30.0 ? Container() : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.location_on),onPressed: () {},color: Theme.of(context).accentColor,),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(top: 5),
                        child: Text("628, 2nd Floor, Sector 9A, Gurgaon, Haryana - 122018", style: Theme.of(context).textTheme.body1,)
                      )
                    ],
                  )
                ],
              ),
            ),
          )
          // shrinkOffset > minExtent - 41 ? Container() : 
        ],
      )
    );
  }

  _showStock(context) {
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
                  child: Text("Current Stock", style: Theme.of(context).textTheme.title)
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

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
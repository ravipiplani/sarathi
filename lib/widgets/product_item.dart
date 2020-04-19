import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String label;
  final String count;

  const ProductItem({Key key, @required this.label, @required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('$label', style: Theme.of(context).textTheme.subtitle1,),
          Text('$count', style: Theme.of(context).textTheme.headline6,)
        ],
      ),
    );
  }
}
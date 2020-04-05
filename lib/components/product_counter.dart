import 'package:flutter/material.dart';
import 'package:yathaarth/components/counter.dart';

class ProductCounter extends StatelessWidget {
  final String label;
  final String count;

  const ProductCounter({Key key, @required this.label, @required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$label', style: Theme.of(context).textTheme.subtitle1,),
          Counter(count: count)
        ],
      ),
    );
  }
}
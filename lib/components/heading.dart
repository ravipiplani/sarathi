import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const Heading({Key key, @required this.text, @required this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c = color;
    if (color == null) {
      c = Theme.of(context).primaryColor;
    }
    return Container(
      width: 300,
      child: Text(this.text, style: Theme.of(context).textTheme.display3.copyWith(fontSize: this.size, color: c), textAlign: TextAlign.center,)
    );
  }
}
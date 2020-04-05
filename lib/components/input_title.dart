import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String title;
  final String desc;

  const InputTitle({Key key, @required this.title, @required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(this.title, style: Theme.of(context).textTheme.headline6),
        Container(
          padding: EdgeInsets.only(top: 4),
          width: 240,
          child: Text(this.desc, style: Theme.of(context).textTheme.caption, textAlign: TextAlign.center,)
        ),
      ],
    );
  }
}
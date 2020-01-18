import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Ghanshyam Distributions", style: Theme.of(context).textTheme.subtitle),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text("10/01/2020", style: Theme.of(context).textTheme.caption)
                )
              ],
            ),
            Text("Rs 3750", style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).primaryColor)),
          ],
        )
      )
    );
  }
}
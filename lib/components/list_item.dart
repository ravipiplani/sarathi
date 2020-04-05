import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String desc;
  final String subTitle;

  const ListItem({Key key, this.title, this.desc, this.subTitle}) : super(key: key);

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
                Text(title, style: Theme.of(context).textTheme.subtitle2),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(desc, style: Theme.of(context).textTheme.caption)
                )
              ],
            ),
            Text(subTitle, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).primaryColor)),
          ],
        )
      )
    );
  }
}
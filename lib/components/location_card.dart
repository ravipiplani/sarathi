import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationCard extends StatefulWidget {
  LocationCard({Key key}) : super(key: key);

  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Mugalpura, Gohana, Haryana - 131301'),
            subtitle: Text('Current Location', style: Theme.of(context).textTheme.caption),
            trailing: IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            )
        )
    );
  }
}

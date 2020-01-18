import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  final String value;
  final String label;
  final List<String> items;
  final Function(String) onChanged;

  const InputSelect({Key key, @required this.value, @required this.label, @required this.items, @required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DropdownButton(
        hint: Text(label),
        underline: Divider(color: Theme.of(context).primaryColor, height: 0),
        isExpanded: true,
        value: value,
        items: items.map((String v) {
          return DropdownMenuItem(
            value: v,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(v.toString()),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      )
    );
  }
}
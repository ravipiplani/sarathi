import 'package:flutter/material.dart';

class FilledInput extends StatelessWidget {
  final String hintText;

  const FilledInput({Key key, @required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        counter: Offstage(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE4E4E4)),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE4E4E4)),
          borderRadius: BorderRadius.circular(20),
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xFFE4E4E4),
        hintText: hintText
      ),
    );
  }
}
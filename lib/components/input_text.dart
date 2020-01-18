import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String validationMessage;
  final TextInputType keyboardType;
  final int maxLength;
  final TextEditingController controller;
  final TextAlign textAlign;

  const InputText({
    Key key,
    this.labelText,
    this.hintText,
    this.validationMessage,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.textAlign = TextAlign.left
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          counter: Offstage(),
          labelText: labelText,
          hasFloatingPlaceholder: true
        ),
        validator: (value) {
          if (value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        keyboardType: keyboardType,
        textAlign: textAlign,
      )
    );
  }
}
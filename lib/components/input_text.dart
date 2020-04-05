import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final TextEditingController controller;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final TextStyle textStyle;

  const InputText({
    Key key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.textAlign,
    this.focusNode,
    this.textStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        focusNode: focusNode ?? null,
        maxLength: maxLength ?? 255,
        controller: controller ?? null,
        style: textStyle ?? null,
        decoration: InputDecoration(
          hintText: hintText ?? null,
          counter: Offstage(),
          filled: true,
          labelText: labelText ?? null,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return '$labelText is a required field.';
          }
          return null;
        },
        keyboardType: keyboardType ?? TextInputType.text,
        textAlign: textAlign ?? TextAlign.left,
      )
    );
  }
}
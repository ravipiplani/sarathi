import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yathaarth/constants/Constants.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: Constants.kPadding16),
        child: FormBuilderTextField(
          attribute: 'searchText',
          initialValue: '',
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Search",
          ),
        ));
  }
}

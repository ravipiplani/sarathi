import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yathaarth/theme.dart';

class NewBeat extends StatelessWidget {
  NewBeat({Key key}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Beat'),
        ),
        floatingActionButton: FloatingActionButton.extended(icon: Icon(Icons.done), label: Text('Create'), onPressed: () {}),
        body: SingleChildScrollView(
            child: FormBuilder(
          key: _fbKey,
          child: Container(
            padding: EdgeInsets.all(YathaarthTheme.kPadding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: YathaarthTheme.kPadding16),
                  child: Icon(Icons.map),
                ),
                FormBuilderTextField(
                  attribute: 'beatName',
                  initialValue: '',
                  maxLength: 255,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(counter: Offstage(), labelText: "Beat Name"),
                ),
                ListTile(leading: Icon(Icons.help_outline), title: Text('Enter the beat name.', style: Theme.of(context).textTheme.caption))
              ],
            ),
          ),
        )));
  }
}

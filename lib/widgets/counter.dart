import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Counter extends StatefulWidget {
  final String count;

  Counter({Key key, @required this.count}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _currentCount;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    _currentCount = int.parse(widget.count);
    _textFieldController.value = TextEditingValue(text: widget.count);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              icon: Icon(Icons.remove, size: 14, color: Theme.of(context).primaryColor),
              onPressed: () {
                if (_currentCount > 0) {
                  _currentCount--;
                  _textFieldController.value = TextEditingValue(text: _currentCount.toString());
                }
              },
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 60,
              child: FormBuilderTextField(
                initialValue: '',
                controller: _textFieldController,
                textAlign: TextAlign.center,
                attribute: 'counter',
                onChanged: (value) {
                  _currentCount = int.parse(value);
                },
              )
            )
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(Icons.add, size: 14, color: Theme.of(context).primaryColor),
              onPressed: () {
                _currentCount++;
                _textFieldController.value = TextEditingValue(text: _currentCount.toString());
              },
            )
          ),
        ],
      ),
    );
  }
}
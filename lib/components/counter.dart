import 'package:flutter/material.dart';
import 'package:yathaarth/components/input_text.dart';

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
            child: FloatingActionButton(
              elevation: 1,
              child: Icon(Icons.remove, size: 14, color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
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
              child: InputText(
                controller: _textFieldController,
                textAlign: TextAlign.center,
              )
            )
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: FloatingActionButton(
              elevation: 1,
              child: Icon(Icons.add, size: 14, color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
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
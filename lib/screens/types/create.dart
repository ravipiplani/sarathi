import 'package:flutter/material.dart';
import 'package:yathaarth/components/heading.dart';
import 'package:yathaarth/components/input_select.dart';
import 'package:yathaarth/components/input_text.dart';
import 'package:yathaarth/components/input_title.dart';
import 'package:yathaarth/keys.dart';

class NewType extends StatefulWidget {
  NewType({Key key}) : super(key: key);

  @override
  _NewTypeState createState() => _NewTypeState();
}

class _NewTypeState extends State<NewType> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  final List<String> _beats = [
    "Beat 1",
    "Beat 2",
    "Beat 3",
    "Beat 4",
    "Beat 5"
  ];
  String _selectedDistributor;
  final List<String> _distributors = [
    "Distributor 1",
    "Distributor 2",
    "Distributor 3",
    "Distributor 4",
    "Distributor 5"
  ];
  String _selectedStockist;
  final List<String> _stockists = [
    "Stockist 1",
    "Stockist 2",
    "Stockist 3",
    "Stockist 4",
    "Stockist 5"
  ];
  String _selectedBeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        onPressed: () {
                          Keys.navigatorKey.currentState.pop();
                        }
                      )
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Heading(
                        text: "New Retail Outlet",
                        size: 32,
                      )
                    ),
                  ],
                )
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InputTitle(
                      title: "Enter Details",
                      desc: "Please provide retailor mobile number and outlet name and other details if required.",
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InputText(
                              maxLength: 255,
                              controller: _controller,
                              labelText: "Outlet Name",
                              hintText: "Please type the outlet name here",
                              validationMessage: "Outlet name is a mandatory field.",
                              keyboardType: TextInputType.text,
                            ),
                            InputText(
                              maxLength: 10,
                              controller: _controller,
                              labelText: "Mobile Number",
                              hintText: "Enter the 10 digit mobile number",
                              validationMessage: "Please enter 10 digit mobile number.",
                              keyboardType: TextInputType.phone,
                            ),
                            InputSelect(
                              items: _beats,
                              value: _selectedBeat,
                              label: "Select Beat",
                              onChanged: (v) {
                                setState(() {
                                  _selectedBeat = v;
                                });
                              },
                            ),
                            InputSelect(
                              items: _distributors,
                              value: _selectedDistributor,
                              label: "Select Distributor",
                              onChanged: (v) {
                                setState(() {
                                  _selectedDistributor = v;
                                });
                              },
                            ),
                            InputSelect(
                              items: _stockists,
                              value: _selectedStockist,
                              label: "Select Stockist",
                              onChanged: (v) {
                                setState(() {
                                  _selectedStockist = v;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 30,
                    child: Icon(Icons.chevron_right, size: 36, color: Colors.white)
                  ),
                  onTap: () {
                    
                  },
                ),
              )
            ],
          )
        )
      )
    );
  }
}
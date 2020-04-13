import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yathaarth/components/heading.dart';
import 'package:yathaarth/components/input_title.dart';
import 'package:yathaarth/keys.dart';

class NewCustomer extends StatefulWidget {
  NewCustomer({Key key}) : super(key: key);

  @override
  _NewCustomerState createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final List<String> _beats = ["Beat 1", "Beat 2", "Beat 3", "Beat 4", "Beat 5"];
  final List<String> _distributors = ["Distributor 1", "Distributor 2", "Distributor 3", "Distributor 4", "Distributor 5"];
  final List<String> _stockists = ["Stockist 1", "Stockist 2", "Stockist 3", "Stockist 4", "Stockist 5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.chevron_right, size: 36, color: Colors.white),
            onPressed: () {

            }),
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
                        child: BackButton(onPressed: () {
                          Keys.navigatorKey.currentState.pop();
                        })),
                    Align(
                        alignment: Alignment.center,
                        child: Heading(
                          text: "New Retail Outlet",
                          size: 32,
                        )),
                  ],
                )),
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
                    FormBuilder(
                      key: _fbKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: 'outletName',
                              initialValue: '',
                              maxLength: 255,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Outlet Name",
                                hintText: "Please type the outlet name here",
                              ),
                            ),
                            FormBuilderTextField(
                              attribute: 'mobile',
                              initialValue: '',
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: "Mobile Number",
                                hintText: "Enter the 10 digit mobile number",
                              ),
                            ),
                            FormBuilderDropdown(
                              attribute: 'beatId',
                              hint: Text('Select Beat'),
                              decoration: InputDecoration(
                                labelText: 'Beat'
                              ),
                              initialValue: _beats.first,
                              items: _beats.map((String v) {
                                return DropdownMenuItem(
                                  value: v,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(v.toString()),
                                  ),
                                );
                              }).toList(),
                            ),
                            FormBuilderDropdown(
                              attribute: 'distributorId',
                              initialValue: _distributors.first,
                              items: _distributors.map((String v) {
                                return DropdownMenuItem(
                                  value: v,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(v.toString()),
                                  ),
                                );
                              }).toList(),
                            ),
                            FormBuilderDropdown(
                              attribute: 'stockistId',
                              initialValue: _stockists.first,
                              items: _stockists.map((String v) {
                                return DropdownMenuItem(
                                  value: v,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(v.toString()),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ))));
  }
}

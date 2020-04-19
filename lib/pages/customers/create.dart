import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:yathaarth/theme.dart';
import 'package:yathaarth/widgets/location_card.dart';

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

  LocationData _locationData;
  Address _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Customer'),
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
                LocationCard(editable: true, callback: updateLocation),
                SizedBox(height: YathaarthTheme.kPadding16,),
                FormBuilderTextField(
                  attribute: 'outletName',
                  initialValue: '',
                  maxLength: 255,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(counter: Offstage(), labelText: "Outlet Name"),
                ),
                SizedBox(height: YathaarthTheme.kPadding16),
                FormBuilderTextField(
                  attribute: 'mobile',
                  initialValue: '',
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(counter: Offstage(), labelText: "Mobile Number", hintText: "Enter the 10 digit mobile number"),
                ),
                SizedBox(height: YathaarthTheme.kPadding16),
                FormBuilderDropdown(
                  attribute: 'beatId',
                  hint: Text('Select Beat'),
                  decoration: InputDecoration(labelText: 'Beat'),
                  initialValue: null,
                  items: _beats.map((String v) {
                    return DropdownMenuItem(value: v, child: Text(v.toString()));
                  }).toList(),
                ),
                SizedBox(height: YathaarthTheme.kPadding16),
                FormBuilderDropdown(
                  attribute: 'distributorId',
                  hint: Text('Select Distributor'),
                  decoration: InputDecoration(labelText: 'Distributor'),
                  initialValue: null,
                  items: _distributors.map((String v) {
                    return DropdownMenuItem(value: v, child: Text(v.toString()));
                  }).toList(),
                ),
                SizedBox(height: YathaarthTheme.kPadding16),
                FormBuilderDropdown(
                  attribute: 'stockistId',
                  hint: Text('Select Stockist'),
                  decoration: InputDecoration(labelText: 'Stockist'),
                  initialValue: null,
                  items: _stockists.map((String v) {
                    return DropdownMenuItem(value: v, child: Text(v.toString()));
                  }).toList(),
                ),
                ListTile(leading: Icon(Icons.help_outline), title: Text('Enter the details to add a new customer.', style: Theme.of(context).textTheme.caption))
              ],
            ),
          ),
        )));
  }

  void updateLocation(LocationData locationData, Address address) {
    _locationData = locationData;
    _address = address;
  }
}

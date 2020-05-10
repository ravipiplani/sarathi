import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:sarathi/data/states.dart';
import 'package:sarathi/keys.dart';
import 'package:sarathi/data/strings.dart';
import 'package:sarathi/models/address.dart' as YAddress;
import 'package:sarathi/theme.dart';

class LocationCard extends StatefulWidget {
  LocationCard({Key key, this.callback, this.editable = false, this.currentAddress}) : super(key: key);

  final void Function(LocationData, YAddress.Address) callback;
  final bool editable;
  final YAddress.Address currentAddress;

  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  var _location = Location();
  bool _serviceEnabled;
  PermissionStatus _permission;
  bool _isLoading;
  Address _address;
  LocationData _locationData;
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _checkLocationPermission();
    _isLoading = false;
    super.initState();
  }

  void _checkLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        print('This app will not work while the location is off.');
        return;
      }
    }

    _permission = await _location.hasPermission();
    if (_permission == PermissionStatus.denied) {
      _permission = await _location.requestPermission();
      if (_permission != PermissionStatus.granted) {
        print('This app will not work without the location permission.');
        return;
      }
    }

    _location.changeSettings(accuracy: LocationAccuracy.balanced);

    _updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            contentPadding: EdgeInsets.all(SarathiTheme.kPadding8),
            leading: widget.editable
                ? IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editAddress();
                    },
                  )
                : Icon(Icons.location_on),
            title: Text(widget.currentAddress != null ? widget.currentAddress.addressLine : _address != null ? _address.addressLine : 'Getting location...'),
            subtitle: Text(Strings.currentLocation, style: Theme.of(context).textTheme.caption),
            trailing: _isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ))
                : IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      _updateLocation();
                    },
                  )));
  }

  void _updateLocation() async {
    if (_serviceEnabled && _permission == PermissionStatus.granted) {
      setState(() {
        _isLoading = true;
      });
      LocationData locationData = await _location.getLocation();
      Coordinates coordinates = Coordinates(locationData.latitude, locationData.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {
        _isLoading = false;
        _locationData = locationData;
        if (addresses.length != 0) {
          _address = addresses.first;
        }
      });

      if (widget.callback != null) {
        _editAddress();
      }
    }
  }

  void _editAddress() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          List<String> _districts = widget.currentAddress != null
              ? States.all[widget.currentAddress.state.toUpperCase()]
              : _address != null ? States.all[_address.adminArea.toUpperCase()] : null;
          FocusNode _addressLine1FN = FocusNode();
          FocusNode _addressLine2FN = FocusNode();
          FocusNode _landmarkFN = FocusNode();
          FocusNode _cityFN = FocusNode();
          FocusNode _pincodeFN = FocusNode();
          return AlertDialog(
            title: Text('Edit Address'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FormBuilder(
                      key: _fbKey,
                      child: ListBody(
                        children: <Widget>[
                          FormBuilderTextField(
                              attribute: 'lat',
                              readOnly: true,
                              initialValue: _locationData != null ? _locationData.latitude.toString() : '',
                              decoration: InputDecoration(labelText: "Lat", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'long',
                              readOnly: true,
                              initialValue: _locationData != null ? _locationData.longitude.toString() : '',
                              decoration: InputDecoration(labelText: "Long", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'address_line_1',
                              initialValue:
                                  widget.currentAddress != null ? widget.currentAddress.addressLine1 : _address != null ? _address.featureName ?? '' : '',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validators: [FormBuilderValidators.required()],
                              focusNode: _addressLine1FN,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(_addressLine2FN);
                              },
                              decoration: InputDecoration(labelText: "Address Line 1", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'address_line_2',
                              initialValue:
                                  widget.currentAddress != null ? widget.currentAddress.addressLine2 : _address != null ? _address.subLocality ?? '' : '',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              focusNode: _addressLine2FN,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(_landmarkFN);
                              },
                              decoration: InputDecoration(labelText: "Address Line 2", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'landmark',
                              initialValue: widget.currentAddress != null ? widget.currentAddress.landmark : '',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              focusNode: _landmarkFN,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(_cityFN);
                              },
                              decoration: InputDecoration(labelText: "Landmark", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'city',
                              validators: [FormBuilderValidators.required()],
                              initialValue: widget.currentAddress != null ? widget.currentAddress.city : _address != null ? _address.locality ?? '' : '',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              focusNode: _cityFN,
                              decoration: InputDecoration(labelText: "City", isDense: true)),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderDropdown(
                            attribute: 'state',
                            validators: [FormBuilderValidators.required()],
                            items: States.all.keys
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e.toLowerCase(),
                                    ))
                                .toList(),
                            initialValue: widget.currentAddress != null
                                ? widget.currentAddress.state.toLowerCase()
                                : _address != null ? _address.adminArea.toLowerCase() ?? null : null,
                            onChanged: (value) {
                              setState(() => _districts = States.all[value.toString().toUpperCase()]);
                            },
                          ),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderDropdown(
                              attribute: 'district',
                              validators: [FormBuilderValidators.required()],
                              items: _districts != null
                                  ? _districts
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e.toLowerCase(),
                                          ))
                                      .toList()
                                  : [],
                              initialValue: widget.currentAddress != null
                                  ? widget.currentAddress.district.toLowerCase()
                                  : _address != null && _districts != null && _districts.contains(_address.subAdminArea.toLowerCase())
                                      ? _address.subAdminArea.toLowerCase()
                                      : null),
                          SizedBox(height: SarathiTheme.kPadding8),
                          FormBuilderTextField(
                              attribute: 'pincode',
                              validators: [FormBuilderValidators.required(), FormBuilderValidators.maxLength(6), FormBuilderValidators.numeric()],
                              initialValue: widget.currentAddress != null ? widget.currentAddress.pincode : _address != null ? _address.postalCode ?? '' : '',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              focusNode: _pincodeFN,
                              decoration: InputDecoration(labelText: "Pincode", isDense: true))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('SAVE'),
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    Keys.navigatorKey.currentState.pop();
                    widget.callback(_locationData, YAddress.Address.fromJson(_fbKey.currentState.value));
                  }
                },
              ),
            ],
          );
        });
  }
}

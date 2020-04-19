import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/strings.dart';
import 'package:yathaarth/theme.dart';

class LocationCard extends StatefulWidget {
  LocationCard({Key key, this.callback, this.editable = false}) : super(key: key);

  final void Function(LocationData, Address) callback;
  final bool editable;

  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  var _location = Location();
  bool _serviceEnabled;
  PermissionStatus _permission;
  bool _isLoading;
  Address _address;
  LocationData _locationData;

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
            contentPadding: EdgeInsets.all(YathaarthTheme.kPadding8),
            leading: widget.editable
                ? IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editAddress();
              },
            )
                : Icon(Icons.location_on),
            title: Text(_address != null ? _address.addressLine : 'Getting location'),
            subtitle: Text(Strings.currentLocation, style: Theme
                .of(context)
                .textTheme
                .caption),
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
        widget.callback(locationData, _address);
      }
    }
  }

  void _editAddress() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Address'),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: ListBody(
                  children: <Widget>[
                    FormBuilderTextField(
                        attribute: 'lat',
                        readOnly: true,
                        initialValue: _locationData != null ? _locationData.latitude.toString() : '',
                        decoration: InputDecoration(labelText: "Lat", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'long',
                        readOnly: true,
                        initialValue: _locationData != null ? _locationData.longitude.toString() : '',
                        decoration: InputDecoration(labelText: "Long", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'address_line_1',
                        initialValue: _address != null ? _address.featureName ?? '' : '',
                        decoration: InputDecoration(labelText: "Address Line 1", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'address_line_2',
                        initialValue: _address != null ? _address.subLocality ?? '' : '',
                        decoration: InputDecoration(labelText: "Address Line 2", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'landmark',
                        initialValue: '',
                        decoration: InputDecoration(labelText: "Landmark", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'city',
                        initialValue: _address != null ? _address.locality ?? '' : '',
                        decoration: InputDecoration(labelText: "City", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'district',
                        initialValue: _address != null ? _address.subAdminArea ?? '' : '',
                        decoration: InputDecoration(labelText: "District", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'state',
                        initialValue: _address != null ? _address.adminArea ?? '' : '',
                        decoration: InputDecoration(labelText: "State", isDense: true)),
                    SizedBox(height: YathaarthTheme.kPadding8),
                    FormBuilderTextField(
                        attribute: 'pincode',
                        initialValue: _address != null ? _address.postalCode ?? '' : '',
                        decoration: InputDecoration(labelText: "Pincode", isDense: true))
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () => Keys.navigatorKey.currentState.pop(),
              ),
              FlatButton(
                child: Text('SAVE'),
                onPressed: () {},
              ),
            ],
          );
        });
  }
}

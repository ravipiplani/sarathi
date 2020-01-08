import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_boilerplate/actions/auth_actions.dart';
import 'package:login_boilerplate/actions/loading_actions.dart';
import 'package:login_boilerplate/keys.dart';
import 'package:login_boilerplate/models/app_state.dart';
import 'package:login_boilerplate/routes.dart';
import 'package:login_boilerplate/screens/otp.dart';
import 'package:redux/redux.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController _controller = TextEditingController();
  String verificationId;
  String countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Screen")
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 23, right: 20),
                  child: InkWell(
                    onTap: _openCountryPickerDialog,
                    child: Text(countryCode, style: Theme.of(context).textTheme.display2.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).primaryColor.withOpacity(0.7))),
                  )
                ),
                Expanded(
                  child: TextFormField(
                    maxLength: 10,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Mobile No"
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter 10 digit mobile number.";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                )
              ],
            ),
            StoreConnector<AppState, _AuthViewModel>(
              converter: _AuthViewModel.fromStore,
              builder: (BuildContext context, _AuthViewModel viewModel) {
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    onPressed: () {
                      viewModel.sendOtp(countryCode + _controller.text);
                    },
                    child: viewModel.isLoading ? Text("Sending...") : Text("Send OTP"),
                  )
                );
              },
            )
          ],
        ),
      )
    );
  }

  void _openCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => CountryPickerDialog(
        titlePadding: EdgeInsets.all(0.0),
        searchInputDecoration: InputDecoration(
          hintText: 'Search...'
        ),
        isSearchable: true,
        title: Text('Country Code'),
        itemBuilder: (Country country) {
          return Container(
            child: Text("+${country.phoneCode} (${country.isoCode})")
          );
        },
        onValuePicked: (country) {
          setState(() {
            countryCode = "+${country.phoneCode}";
          });
        },
      )
    );
  }
}

class _AuthViewModel {
  final bool isLoading;
  final Function(String) sendOtp;

  _AuthViewModel({
    this.isLoading,
    this.sendOtp
  });

  static _AuthViewModel fromStore(Store<AppState> store) {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      store.dispatch(StopLoading());
      Keys.navigatorKey.currentState.pushNamed(Routes.otpScreen, arguments: OtpArguments(verificationId: verId));
    };
    return _AuthViewModel(
      isLoading: store.state.isLoading,
      sendOtp: (String mobile) {
        store.dispatch(UpdateUser(keyValues: {'mobile': mobile}));
        store.dispatch(SendOTP(
          phone: mobile,
          codeSent: smsOTPSent,
          codeAutoRetrievalTimeout: (String verId) {
          },
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}');
          }
        ));
      }
    );
  }
}
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yathaarth/actions/auth_actions.dart';
import 'package:yathaarth/actions/loading_actions.dart';
import 'package:yathaarth/components/heading.dart';
import 'package:yathaarth/components/input_title.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/app_state.dart';
import 'package:yathaarth/routes.dart';
import 'package:yathaarth/screens/otp.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              child: Heading(
                text: "Yathaarth",
                size: 48,
              )
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InputTitle(
                      title: "Mobile Verification",
                      desc: "Please enter your mobile number",
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: _openCountryPickerDialog,
                                    child: Text(countryCode, style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).accentColor)),
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: StoreConnector<AppState, _AuthViewModel>(
                converter: _AuthViewModel.fromStore,
                builder: (BuildContext context, _AuthViewModel viewModel) {
                  return viewModel.isLoading ? CircularProgressIndicator() : InkWell(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 30,
                      child: Icon(Icons.chevron_right, size: 36, color: Colors.white)
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        viewModel.sendOtp(countryCode + _controller.text);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Sending OTP...')
                        ));
                      }
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Text("Terms & Conditions", style: Theme.of(context).textTheme.caption)
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
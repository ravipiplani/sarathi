import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_boilerplate/actions/auth_actions.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Screen")
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              maxLength: 15,
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
            StoreConnector<AppState, _AuthViewModel>(
              converter: _AuthViewModel.fromStore,
              builder: (BuildContext context, _AuthViewModel viewModel) {
                return RaisedButton(
                  onPressed: () {
                    viewModel.sendOtp(_controller.text);
                  },
                  child: viewModel.isLoading ? Text("Sending...") : Text("Send OTP"),
                );
              },
            )
          ],
        ),
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
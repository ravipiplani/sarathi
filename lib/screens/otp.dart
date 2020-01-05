import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:login_boilerplate/actions/auth_actions.dart';
import 'package:login_boilerplate/models/app_state.dart';
import 'package:redux/redux.dart';

class OtpArguments {
  final String verificationId;

  OtpArguments({this.verificationId});
}

class Otp extends StatefulWidget {
  Otp({Key key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  FocusNode _focusNode = FocusNode();
  final TextEditingController _textFieldController = TextEditingController();
  String phoneNo;
  String otp;
  String verificationId;

  @override
  Widget build(BuildContext context) {
    final OtpArguments args = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    verificationId = args.verificationId;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Auth Screen"),
      ),
      body: StoreConnector<AppState, _OtpViewModel>(
        converter: _OtpViewModel.fromStore,
        // onDidChange: (_OtpViewModel viewModel) {
        //   if (viewModel.hasLogInFailed) {
        //     print("Login Failed");
        //     _scaffoldKey.currentState.showSnackBar(SnackBar(
        //       content: Text("Verification failed.")
        //     ));
        //   }
        // },
        builder: (BuildContext context, _OtpViewModel viewModel) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLength: 10,
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    hintText: 'OOOOOO',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter 10 digit mobile number.";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Please enter the OTP received on ' + viewModel.mobile),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    child: viewModel.isLoading ? Text("Verifying...") : Text('Verify'),
                    onPressed: () {
                      viewModel.verifyOtp(verificationId, _textFieldController.text, _scaffoldKey);
                    },
                  )
                )
              ],
            ),
          );
        },
      )
    );
  }
}

class _OtpViewModel {
  final bool isLoading;
  final bool hasLogInFailed;
  final String mobile;
  final Function(String, String, GlobalKey) verifyOtp;

  _OtpViewModel({
    this.isLoading,
    this.hasLogInFailed,
    this.mobile,
    this.verifyOtp
  });

  static _OtpViewModel fromStore(Store<AppState> store) {
    return _OtpViewModel(
      isLoading: store.state.isLoading,
      hasLogInFailed: store.state.authState.hasLogInFailed,
      mobile: store.state.authState.user.mobile,
      verifyOtp: (verificationId, otp, key) {
        store.dispatch(VerifyOTP(
          otp: otp,
          verificationId: verificationId,
          key: key
        ));
      }
    );
  }
}
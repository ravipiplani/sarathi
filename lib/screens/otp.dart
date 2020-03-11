import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yathaarth/actions/auth_actions.dart';
import 'package:yathaarth/components/heading.dart';
import 'package:yathaarth/components/input_title.dart';
import 'package:yathaarth/models/app_state.dart';
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
  final TextEditingController _textFieldController = TextEditingController();
  String phoneNo;
  String otp;
  String verificationId;

  @override
  Widget build(BuildContext context) {
    final OtpArguments args = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _focusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();

    verificationId = args.verificationId;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: StoreConnector<AppState, _OtpViewModel>(
        converter: _OtpViewModel.fromStore,
        builder: (BuildContext context, _OtpViewModel viewModel) {
          return SafeArea(
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
                          title: "Enter OTP",
                          desc: "One Time Password (OTP) has been sent to your mobile number. Please enter the same here to login.",
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(32),
                            width: 252,
                            child: TextFormField(
                              focusNode: _focusNode,
                              maxLength: 6,
                              controller: _textFieldController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'OOOOOO',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter 6 digit otp received on " + viewModel.mobile + ".";
                                }
                                return null;
                              },
                              style: TextStyle(letterSpacing: 20),
                              keyboardType: TextInputType.number
                            ),
                          ),
                        )
                      ],
                    )
                  )
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: viewModel.isLoading ? CircularProgressIndicator() : InkWell(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 30,
                      child: Icon(Icons.chevron_right, size: 36, color: Colors.white)
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        viewModel.verifyOtp(verificationId, _textFieldController.text, _scaffoldKey);
                      }
                    },
                  )
                ),
                Expanded(
                  child: Text("Didn't receive the OTP?", style: Theme.of(context).textTheme.caption)
                )
              ]
            )
          );
        }
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
      mobile: store.state.authState.mobile,
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
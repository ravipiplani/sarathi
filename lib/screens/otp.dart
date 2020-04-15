import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yathaarth/components/input_title.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/responses/get_token_response.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/services/user_service.dart';

class OtpArguments {
  final String verificationId;
  final String mobile;

  OtpArguments({this.verificationId, this.mobile});
}

class Otp extends StatefulWidget {
  Otp({Key key, this.verificationId, this.mobile}) : super(key: key);

  final String verificationId;
  final String mobile;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _storage = FlutterSecureStorage();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String otp;
  bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.chevron_right, size: 36, color: Colors.white),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                verifyOTP(widget.verificationId, _textFieldController.text);
              }
            }),
        body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              padding: EdgeInsets.all(40),
              child: Text(
                'Yathaarth',
                style: Theme.of(context).textTheme.headline1,
              )),
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
                          child: FormBuilderTextField(
                            attribute: 'otp',
                            focusNode: _focusNode,
                            maxLength: 6,
                            controller: _textFieldController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'OOOOOO',
                              hintStyle: TextStyle(letterSpacing: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
          Expanded(child: Text("Didn't receive the OTP?", style: Theme.of(context).textTheme.caption))
        ])));
  }

  Future<void> verifyOTP(String verificationId, String otp) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      final IdTokenResult idToken = await user.getIdToken();
      final GetTokenResponse data = await getToken(idToken.token, 'dealer');
      await _storage.write(key: 'token', value: data.token);
      setState(() {
        isLoading = false;
      });
      Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(Router.homeRoute, (Route<dynamic> route) => false);
    } catch (error) {
      print(error);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verification failed.'),
        backgroundColor: Colors.black,
      ));
    }
  }

  Future<GetTokenResponse> getToken(String idToken, String type) async {
    final UserService _authService = UserService();
    final GetTokenResponse response = await _authService.getToken(idToken: idToken);
    return response;
  }
}

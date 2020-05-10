import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sarathi/widgets/input_title.dart';
import 'package:sarathi/keys.dart';
import 'package:sarathi/router.dart';
import 'otp.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String countryCode = "+91";
  String mobile;
  bool isLoading;

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _focusNode = FocusNode();

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
                mobile = _controller.text;
                _focusNode.unfocus();
                sendOTP();
              }
            }),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'Sarathi',
                    style: Theme.of(context).textTheme.headline1,
                  )),
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
                                            child: Text(countryCode,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).accentColor)),
                                          )),
                                      Expanded(
                                        child: FormBuilderTextField(
                                          attribute: 'mobile',
                                          focusNode: _focusNode,
                                          maxLength: 10,
                                          controller: _controller,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(labelText: "Mobile No"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ))),
              Expanded(child: Text("Terms & Conditions", style: Theme.of(context).textTheme.caption))
            ],
          ),
        ));
  }

  void _openCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
              titlePadding: EdgeInsets.all(0.0),
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Country Code'),
              itemBuilder: (Country country) {
                return Container(child: Text("+${country.phoneCode} (${country.isoCode})"));
              },
              onValuePicked: (country) {
                setState(() {
                  countryCode = "+${country.phoneCode}";
                });
              },
            ));
  }

  void sendOTP() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: '+91$mobile',
          codeAutoRetrievalTimeout: (String verId) {},
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}');
          });
    } catch (error) {
      print(error);
    }
  }

  void smsOTPSent(String verId, [int forceCodeResend]) {
    setState(() {
      isLoading = false;
    });
    Keys.navigatorKey.currentState.pushNamed(Router.otpRoute, arguments: OtpArguments(verificationId: verId, mobile: mobile));
    return;
  }
}

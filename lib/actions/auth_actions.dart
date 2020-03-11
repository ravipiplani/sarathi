import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SendOTP {
  final String phone;
  final PhoneCodeSent codeSent;
  final PhoneVerificationCompleted verificationCompleted;
  final PhoneVerificationFailed verificationFailed;
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;

  SendOTP({@required this.phone, @required this.codeSent, @required this.verificationCompleted, @required this.verificationFailed, @required this.codeAutoRetrievalTimeout });

  @override
  String toString() {
    return 'SendOTP{phone: $phone, codeSent: $codeSent, verificationCompleted: $verificationCompleted, verificationFailed: $verificationFailed, codeAutoRetrievalTimeout: $codeAutoRetrievalTimeout}';
  }
}

class VerifyOTP {
  final String verificationId;
  final String otp;
  final GlobalKey<ScaffoldState> key;

  VerifyOTP({@required this.verificationId, @required this.otp, @required this.key});

  @override
  String toString() {
    return 'VerifyOTP{verificationId: $verificationId, otp: $otp}';
  }
}

class GetToken {
  final String uid;

  GetToken({@required this.uid});

  @override
  String toString() {
    return 'GetToken{uid: $uid}';
  }
}

class LogInSuccessful {
  final String token;

  LogInSuccessful({ @required this.token });

  @override
  String toString() {
    return 'LogInSuccessful{token: $token}';
  }
}

class LogInFail {
  final dynamic error;

  LogInFail({this.error});

  @override
  String toString() {
    return 'LogInFail{There was an error loggin in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();
  @override
  String toString() {
    return 'LogOutSuccessful{user: null}';
  }
}
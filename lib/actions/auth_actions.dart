import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_boilerplate/models/user.dart';

class CheckIfUserExists {
  final String mobile;

  CheckIfUserExists({this.mobile});

  @override
  String toString() {
    return 'CheckIfUserExists{mobile: $mobile}';
  }
}

class AlreadyExists {
  final User user;

  AlreadyExists({this.user});

  @override
  String toString() {
    return 'AlreadyExists{user: $user}';
  }
}

class NewUser {}

class UpdateUser {
  final Map<String, dynamic> keyValues;

  UpdateUser({this.keyValues});

  @override
  String toString() {
    return 'UpdateUser{keyValues: $keyValues}';
  }
}

class RegisterUser {}

class UserRegistered {}

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

class LogInSuccessful {
  final FirebaseUser user;

  LogInSuccessful({ @required this.user });

  @override
  String toString() {
    return 'LogInSuccessful{user: $user}';
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
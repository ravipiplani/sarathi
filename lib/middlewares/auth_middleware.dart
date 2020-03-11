import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/actions/auth_actions.dart';
import 'package:yathaarth/actions/loading_actions.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/models/app_state.dart';
import 'package:yathaarth/routes.dart';
import 'package:redux/redux.dart';
import 'package:yathaarth/services/user_service.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final sendOTP = _createSendOTPMiddleware();
  final verifyOTP = _createVerifyOTPMiddleware();
  final getToken = _createGetTokenMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
    TypedMiddleware<AppState, SendOTP>(sendOTP),
    TypedMiddleware<AppState, VerifyOTP>(verifyOTP),
    TypedMiddleware<AppState, GetToken>(getToken),
    TypedMiddleware<AppState, LogOut>(logOut),
  ];
}

Middleware<AppState> _createSendOTPMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is SendOTP) {
      try {
        store.dispatch(StartLoading());
        await _auth.verifyPhoneNumber(
          phoneNumber: action.phone,
          codeAutoRetrievalTimeout: action.codeAutoRetrievalTimeout,
          codeSent: action.codeSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: action.verificationCompleted,
          verificationFailed: action.verificationFailed
        );
      }
      catch (error) {
        store.dispatch(StopLoading());
        print(error);
      }
    }
    next(action);
  };
}

Middleware<AppState> _createVerifyOTPMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is VerifyOTP) {
      try {
        store.dispatch(StartLoading());
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: action.verificationId,
          smsCode: action.otp,
        );
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        store.dispatch(GetToken(uid: user.uid));
      }
      catch (error) {
        store.dispatch(StopLoading());
        store.dispatch(LogInFail(error: error));
        action.key.currentState.showSnackBar(SnackBar(
          content: Text("Verification failed.")
        ));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createGetTokenMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final UserService _userService = UserService();

    if (action is GetToken) {
      try {
        store.dispatch(StartLoading());
        final ApiResponse response = await _userService.getToken(uid: action.uid);
        Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.homeScreen, (Route<dynamic> route) => false);
        store.dispatch(StopLoading());
        store.dispatch(LogInSuccessful(token: response.data['token']));
      }
      catch (error) {
        store.dispatch(StopLoading());
        store.dispatch(LogInFail(error: error));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
		final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      print('logging out...');
      Keys.navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.authScreen, (Route<dynamic> route) => false);
      store.dispatch(LogOutSuccessful());
    } catch (error) {
      print(error);
    }
	};
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_boilerplate/actions/auth_actions.dart';
import 'package:login_boilerplate/actions/loading_actions.dart';
import 'package:login_boilerplate/keys.dart';
import 'package:login_boilerplate/models/app_state.dart';
import 'package:login_boilerplate/models/user.dart';
import 'package:login_boilerplate/routes.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final checkIfUserExists = _createCheckIfUserExistsMiddleware();
  final resgiterUser = _createRegisterUserMiddleware();
  final sendOTP = _createSendOTPMiddleware();
  final verifyOTP = _createVerifyOTPMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
    TypedMiddleware<AppState, CheckIfUserExists>(checkIfUserExists),
    TypedMiddleware<AppState, RegisterUser>(resgiterUser),
    TypedMiddleware<AppState, SendOTP>(sendOTP),
    TypedMiddleware<AppState, VerifyOTP>(verifyOTP),
    TypedMiddleware<AppState, LogOut>(logOut),
  ];
}

Middleware<AppState> _createCheckIfUserExistsMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is CheckIfUserExists) {
      try {
        store.dispatch(StartLoading());
        Firestore.instance.collection('users').where('mobile', isEqualTo: action.mobile).getDocuments(source: Source.server).then((querySnapshot) {
          List<User> users = querySnapshot.documents.map((documentSnapshot) {
            return User.fromJson(documentSnapshot.data);
          }).toList();
          if (users.isNotEmpty && users.first.isRegistered){
            Keys.navigatorKey.currentState.pushNamed(Routes.otpScreen);
            store.dispatch(AlreadyExists(user: users.first));
          }
          else {
            store.dispatch(NewUser());
          }
          store.dispatch(StopLoading());
        });
      }
      catch (e) {
        // throw the Firebase AuthException that we caught
        throw new AuthException(e.code, e.message);
      }
    }
    next(action);
  };
}

Middleware<AppState> _createRegisterUserMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegisterUser) {
      try {
        store.dispatch(StartLoading());
        User user = store.state.authState.user;
        user = user.copyWith(
          isRegistered: true
        );
        Firestore.instance.collection('users').add(user.toJson()).then((result) {
          store.dispatch(UserRegistered());
        });
      }
      catch (e) {
        // throw the Firebase AuthException that we caught
        throw new AuthException(e.code, e.message);
      }
    }
    next(action);
  };
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
        store.dispatch(StopLoading());
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
        Keys.navigatorKey.currentState.pushReplacementNamed(Routes.homeScreen);
        store.dispatch(StopLoading());
        store.dispatch(LogInSuccessful(user: user));
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
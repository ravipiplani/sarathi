import 'package:yathaarth/actions/auth_actions.dart';
import 'package:yathaarth/models/auth_state.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, SendOTP>(_sendOTP),
  TypedReducer<AuthState, LogInSuccessful>(_logIn),
  TypedReducer<AuthState, LogInFail>(_logInFail),
  TypedReducer<AuthState, LogOutSuccessful>(_logOut)
]);

AuthState _sendOTP(AuthState authState, SendOTP action) {
  return authState.copyWith(mobile: action.phone);
}

AuthState _logIn(AuthState authState, LogInSuccessful action) {
  return authState.copyWith(isAuthenticated: true, hasLogInFailed: false, token: action.token);
}

AuthState _logInFail(AuthState authState,LogInFail action) {
  return authState.copyWith(hasLogInFailed: true);
}

AuthState _logOut(AuthState authState, LogOutSuccessful action) {
  return authState.copyWith(isAuthenticated: false, token: null);
}
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.g.dart';

@JsonSerializable()
@immutable
class AuthState {
  final bool isAuthenticated;
  final bool hasLogInFailed;
  final bool isNewUser;
  final String token;
  final String mobile;

  AuthState({
    this.isAuthenticated,
    this.hasLogInFailed,
    this.isNewUser,
    this.token,
    this.mobile
  });

  AuthState copyWith({bool isAuthenticated, bool hasLogInFailed, bool isNewUser, String token, String mobile}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      hasLogInFailed: hasLogInFailed ?? this.hasLogInFailed,
      isNewUser: isNewUser ?? this.isNewUser,
      token: token ?? this.token,
      mobile: mobile ?? this.mobile
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  @override
  String toString() {
    return 'AuthState{isAuthenticated: $isAuthenticated, hasLogInFailed: $hasLogInFailed, isNewUser: $isNewUser, token: $token, mobile: $mobile}';
  }
}
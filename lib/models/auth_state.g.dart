// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return AuthState(
    isAuthenticated: json['isAuthenticated'] as bool,
    hasLogInFailed: json['hasLogInFailed'] as bool,
    isNewUser: json['isNewUser'] as bool,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'hasLogInFailed': instance.hasLogInFailed,
      'isNewUser': instance.isNewUser,
      'user': instance.user,
    };

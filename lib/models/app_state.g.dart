// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    isLoading: json['isLoading'] as bool,
    authState: json['authState'] == null
        ? null
        : AuthState.fromJson(json['authState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'isLoading': instance.isLoading,
      'authState': instance.authState,
    };

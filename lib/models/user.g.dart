// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    isRegistered: json['isRegistered'] as bool,
    mobile: json['mobile'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'isRegistered': instance.isRegistered,
      'mobile': instance.mobile,
    };

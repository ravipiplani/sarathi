// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int,
    addressableType: json['addressableType'] as String,
    addressableId: json['addressableId'] as int,
    addressLine1: json['addressLine1'] as String,
    addressLine2: json['addressLine2'] as String,
    landmark: json['landmark'] as String,
    city: json['city'] as String,
    pincode: json['pincode'] as String,
    lat: json['lat'] as String,
    long: json['long'] as String,
    state: json['state'] as String,
    stateId: json['stateId'] as int,
    district: json['district'] as String,
    districtId: json['districtId'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'addressableType': instance.addressableType,
      'addressableId': instance.addressableId,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'landmark': instance.landmark,
      'city': instance.city,
      'pincode': instance.pincode,
      'lat': instance.lat,
      'long': instance.long,
      'state': instance.state,
      'stateId': instance.stateId,
      'district': instance.district,
      'districtId': instance.districtId,
    };

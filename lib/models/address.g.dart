// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int,
    addressableType: json['addressable_type'] as String,
    addressableId: json['addressable_id'] as int,
    addressLine1: json['address_line_1'] as String,
    addressLine2: json['address_line_2'] as String,
    landmark: json['landmark'] as String,
    city: json['city'] as String,
    pincode: json['pincode'] as String,
    lat: json['lat'] as String,
    long: json['long'] as String,
    state: Address._toState(json['state'] as Map<String, dynamic>),
    stateId: json['state_id'] as int,
    district: Address._toDistrict(json['district'] as Map<String, dynamic>),
    districtId: json['district_id'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'addressable_type': instance.addressableType,
      'addressable_id': instance.addressableId,
      'address_line_1': instance.addressLine1,
      'address_line_2': instance.addressLine2,
      'landmark': instance.landmark,
      'city': instance.city,
      'pincode': instance.pincode,
      'lat': instance.lat,
      'long': instance.long,
      'state': instance.state,
      'state_id': instance.stateId,
      'district': instance.district,
      'district_id': instance.districtId,
    };

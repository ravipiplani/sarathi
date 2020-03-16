import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final String addressableType;
  final int addressableId;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String pincode;
  final String lat;
  final String long;
  final String state;
  final int stateId;
  final String district;
  final int districtId;

  Address({this.id, this.addressableType, this.addressableId, this.addressLine1, this.addressLine2, this.landmark, this.city, this.pincode, this.lat, this.long, this.state, this.stateId, this.district, this.districtId});

  Address copyWith({int id, String addressableType, String addressableId, String addressLine1, String addressLine2, String landmark, String city, String pincode, String lat, String long, String state, int stateId, String district, int districtId}) {
    return Address(
        id: id ?? this.id,
        addressableType: addressableType ?? this.addressableType,
        addressableId: addressableId ?? this.addressableId,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        landmark: landmark ?? this.landmark,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        state: state ?? this.state,
        stateId: stateId ?? this.stateId,
        district: district ?? this.district,
        districtId: districtId ?? this.districtId
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return 'Address{id: $id, addressLine1: $addressLine1}';
  }
}
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  @JsonKey(name: 'address_line_1')
  final String addressLine1;
  @JsonKey(name: 'address_line_2')
  final String addressLine2;
  final String landmark;
  final String city;
  final String pincode;
  final String lat;
  final String long;
  @JsonKey(fromJson: _toState)
  final String state;
  @JsonKey(name: 'state_id')
  final int stateId;
  @JsonKey(fromJson: _toDistrict)
  final String district;
  @JsonKey(name: 'district_id')
  final int districtId;

  Address(
      {this.id,
      this.addressLine1,
      this.addressLine2,
      this.landmark,
      this.city,
      this.pincode,
      this.lat,
      this.long,
      this.state,
      this.stateId,
      this.district,
      this.districtId});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return 'Address{id: $id, addressLine1: $addressLine1, addressLine2: $addressLine2, landmark: $landmark, city: $city, pincode: $pincode, lat: $lat, long: $long, state: $state, stateId: $stateId, district: $district, districtId: $districtId}';
  }

  String get addressLine {
    return '$addressLine1 ${addressLine2 ?? '$addressLine2'} ${landmark ?? '$landmark'}, $city ($district), India - $pincode';
  }

  static String _toState(dynamic state) {
    return state != null && state.runtimeType.toString() == 'String' ? state : state['name'] ?? '';
  }

  static String _toDistrict(dynamic district) {
    return district != null && district.runtimeType.toString() == 'String' ? district : district['name'] ?? '';
  }
}

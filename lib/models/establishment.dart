import 'package:json_annotation/json_annotation.dart';
import 'package:yathaarth/models/address.dart';
import 'package:yathaarth/models/establishment_type.dart';
import 'package:yathaarth/models/status.dart';
import 'package:yathaarth/models/user.dart';

part 'establishment.g.dart';

@JsonSerializable()
class Establishment {
  final int id;
  final String name;
  @JsonKey(name: 'contact_name')
  final String contactName;
  final String mobile;
  final String gst;
  final String pan;
  final String remarks;
  @JsonKey(name: 'parent_establishment_id')
  final String parentEstablishmentId;
  @JsonKey(name: 'registration_date')
  final DateTime registrationDate;
  final User assignee;
  final Status status;
  final EstablishmentType type;
  final Address address;

  Establishment({
    this.id,
    this.name,
    this.contactName,
    this.mobile,
    this.gst,
    this.pan,
    this.remarks,
    this.parentEstablishmentId,
    this.assignee,
    this.registrationDate,
    this.status,
    this.type,
    this.address
  });

  factory Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);

  @override
  String toString() {
    return 'Establishment{id: $id, name: $name, contactName: $contactName, mobile: $mobile, gst: $gst, pan: $pan, remarks: $remarks, parentEstablishmentId: $parentEstablishmentId, assignee: $assignee, registrationDate: $registrationDate, status: $status, type: $type, address: $address}';
  }
}
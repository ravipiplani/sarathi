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
  final String contactName;
  final String mobile;
  final String gst;
  final String pan;
  final String remarks;
  final String parentEstablishmentId;
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
    this.status,
    this.type,
    this.address
  });

  Establishment copyWith({int id, String name, String contactName, String mobile, String gst, String pan, String remarks, int parentEstablishmentId, User assignee, Status status, EstablishmentType type, Address address}) {
    return Establishment(
      id: id ?? this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      mobile: mobile ?? this.mobile,
      gst: gst ?? this.gst,
      pan: pan ?? this.pan,
      remarks: remarks ?? this.remarks,
      parentEstablishmentId: parentEstablishmentId ?? this.parentEstablishmentId,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
      type: type ?? this.type,
      address: address ?? this.address
    );
  }

  factory Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);

  @override
  String toString() {
    return 'Establishment{id: $id, name: $name}';
  }
}
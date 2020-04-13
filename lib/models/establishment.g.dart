// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Establishment _$EstablishmentFromJson(Map<String, dynamic> json) {
  return Establishment(
    id: json['id'] as int,
    name: json['name'] as String,
    contactName: json['contact_name'] as String,
    mobile: json['mobile'] as String,
    gst: json['gst'] as String,
    pan: json['pan'] as String,
    remarks: json['remarks'] as String,
    parentEstablishmentId: json['parent_establishment_id'] as String,
    assignee: json['assignee'] == null
        ? null
        : User.fromJson(json['assignee'] as Map<String, dynamic>),
    registrationDate: json['registration_date'] == null
        ? null
        : DateTime.parse(json['registration_date'] as String),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    type: json['type'] == null
        ? null
        : EstablishmentType.fromJson(json['type'] as Map<String, dynamic>),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contact_name': instance.contactName,
      'mobile': instance.mobile,
      'gst': instance.gst,
      'pan': instance.pan,
      'remarks': instance.remarks,
      'parent_establishment_id': instance.parentEstablishmentId,
      'registration_date': instance.registrationDate?.toIso8601String(),
      'assignee': instance.assignee,
      'status': instance.status,
      'type': instance.type,
      'address': instance.address,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Establishment _$EstablishmentFromJson(Map<String, dynamic> json) {
  return Establishment(
    id: json['id'] as int,
    name: json['name'] as String,
    contactName: json['contactName'] as String,
    mobile: json['mobile'] as String,
    gst: json['gst'] as String,
    pan: json['pan'] as String,
    remarks: json['remarks'] as String,
    parentEstablishmentId: json['parentEstablishmentId'] as String,
    assignee: json['assignee'] == null
        ? null
        : User.fromJson(json['assignee'] as Map<String, dynamic>),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    type: json['type'] == null
        ? null
        : EstablishmentType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactName': instance.contactName,
      'mobile': instance.mobile,
      'gst': instance.gst,
      'pan': instance.pan,
      'remarks': instance.remarks,
      'parentEstablishmentId': instance.parentEstablishmentId,
      'assignee': instance.assignee,
      'status': instance.status,
      'type': instance.type,
    };

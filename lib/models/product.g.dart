// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    taxRate: json['taxRate'] as String,
    variations: (json['variations'] as List)
        ?.map((e) => e == null
            ? null
            : ProductVariation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'taxRate': instance.taxRate,
      'variations': instance.variations,
    };

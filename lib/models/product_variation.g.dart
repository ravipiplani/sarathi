// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) {
  return ProductVariation(
    id: json['id'] as int,
    productId: json['productId'] as int,
    weight: json['weight'] as String,
    unitPrice: (json['unitPrice'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    boxQuantity: json['boxQuantity'] as int,
    boxPrice: (json['boxPrice'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    displayName: json['displayName'] as String,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductVariationToJson(ProductVariation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'weight': instance.weight,
      'unitPrice': instance.unitPrice,
      'boxQuantity': instance.boxQuantity,
      'boxPrice': instance.boxPrice,
      'displayName': instance.displayName,
      'product': instance.product,
    };

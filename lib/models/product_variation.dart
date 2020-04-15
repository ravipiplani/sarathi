import 'package:json_annotation/json_annotation.dart';
import 'package:yathaarth/models/product.dart';

part 'product_variation.g.dart';

@JsonSerializable()
class ProductVariation {
  int id;
  int productId;
  String weight;
  Map<String, double> unitPrice;
  int boxQuantity;
  Map<String, double> boxPrice;
  String displayName;
  Product product;

  ProductVariation({this.id,
    this.productId,
    this.weight,
    this.unitPrice,
    this.boxQuantity,
    this.boxPrice,
    this.displayName,
    this.product});

  factory ProductVariation.fromJson(Map<String, dynamic> json) => _$ProductVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariationToJson(this);

  @override
  String toString() {
    return 'ProductVariation{id: $id, productId: $productId, weight: $weight, unitPrice: $unitPrice, boxQuantity: $boxQuantity, boxPrice: $boxPrice, displayName: $displayName, product: $product}';
  }
}
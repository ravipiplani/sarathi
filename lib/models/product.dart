import 'package:json_annotation/json_annotation.dart';
import 'package:yathaarth/models/product_variation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String name;
  String code;
  String taxRate;
  List<ProductVariation> variations;

  Product({this.id, this.name, this.code, this.taxRate, this.variations});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, code: $code, taxRate: $taxRate, variations: $variations}';
  }
}
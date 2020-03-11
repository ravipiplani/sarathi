import 'package:json_annotation/json_annotation.dart';

part 'establishment_type.g.dart';

@JsonSerializable()
class EstablishmentType {
  final int id;
  final String name;
  final String color;

  EstablishmentType({
    this.id,
    this.name,
    this.color
  });

  EstablishmentType copyWith({int id, String name, String color}) {
    return EstablishmentType(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color
    );
  }

  factory EstablishmentType.fromJson(Map<String, dynamic> json) => _$EstablishmentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentTypeToJson(this);

  @override
  String toString() {
    return 'User{id: $id, name: $name, color: $color}';
  }
}
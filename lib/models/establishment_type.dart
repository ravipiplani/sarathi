import 'package:json_annotation/json_annotation.dart';

part 'establishment_type.g.dart';

@JsonSerializable()
class EstablishmentType {
  final int id;
  final String name;

  EstablishmentType({
    this.id,
    this.name
  });

  EstablishmentType copyWith({int id, String name}) {
    return EstablishmentType(
        id: id ?? this.id,
        name: name ?? this.name,
    );
  }

  factory EstablishmentType.fromJson(Map<String, dynamic> json) => _$EstablishmentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentTypeToJson(this);

  @override
  String toString() {
    return 'EstablishmentType{id: $id, name: $name}';
  }
}
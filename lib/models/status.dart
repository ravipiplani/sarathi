import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  final int id;
  final String name;

  Status({
    this.id,
    this.name
  });

  Status copyWith({int id, String name}) {
    return Status(
        id: id ?? this.id,
        name: name ?? this.name
    );
  }

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  String toString() {
    return 'Status{id: $id, name: $name}';
  }
}
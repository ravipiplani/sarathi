import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  int id;
  String label;
  String color;
  int count;

  HomeResponse({this.id, this.label, this.color, this.count});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  @override
  String toString() {
    return 'HomeResponse{id: $id, label: $label, color: $color, count: $count}';
  }
}
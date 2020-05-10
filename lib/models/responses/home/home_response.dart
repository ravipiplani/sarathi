import 'package:json_annotation/json_annotation.dart';
import 'package:sarathi/models/user.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  Map<String, int> stats;
  User user;

  HomeResponse({this.stats, this.user});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  @override
  String toString() {
    return 'HomeResponse{user: $user, stats: $stats}';
  }
}
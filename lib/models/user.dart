import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final bool isRegistered;
  final String mobile;

  User({
    this.isRegistered = false,
    this.mobile
  });

  User copyWith({bool isRegistered, String mobile}) {
    return User(
      isRegistered: isRegistered ?? this.isRegistered,
      mobile: mobile ?? this.mobile
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{isRegistered: $isRegistered, mobile: $mobile}';
  }
}
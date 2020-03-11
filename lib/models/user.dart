import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final bool isRegistered;
  final int id;
  final String name;
  final String mobile;
  final String email;

  User({
    this.isRegistered = false,
    this.id,
    this.name,
    this.mobile,
    this.email
  });

  User copyWith({bool isRegistered, int id, String name, String mobile, String email}) {
    return User(
      isRegistered: isRegistered ?? this.isRegistered,
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{isRegistered: $isRegistered, id: $id, name: $name, mobile: $mobile, email: $email}';
  }
}
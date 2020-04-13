import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String mobile;
  final String email;

  User({
    this.name,
    this.mobile,
    this.email
  });

  User copyWith({String name, String mobile, String email}) {
    return User(
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{name: $name, mobile: $mobile, email: $email}';
  }
}
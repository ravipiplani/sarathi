import 'package:json_annotation/json_annotation.dart';

part 'get_token_response.g.dart';

@JsonSerializable()
class GetTokenResponse {
  GetTokenResponse({this.token});

  final String token;

  GetTokenResponse copyWith({String token}) {
    return GetTokenResponse(
      token: token ?? this.token,
    );
  }

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) => _$GetTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTokenResponseToJson(this);

  @override
  String toString() {
    return 'GetTokenResponse{token: $token}';
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final String message;
  final Map<String, List<String>> errors;
  final dynamic data;

  ApiResponse({
    this.message,
    this.errors,
    this.data
  });

  ApiResponse copyWith({String message, Map<String, List<String>> errors, dynamic data}) {
    return ApiResponse(
        message: message ?? this.message,
        errors: errors ?? this.errors,
        data: data ?? this.data
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  String toString() {
    return 'ApiResponse{message: $message, errors: $errors, data: $data}';
  }
}
import 'package:flutter_test/flutter_test.dart';
import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/services/user_service.dart';

void main() {
  test('API should fetch the token', () async {
    final userService = UserService();
    ApiResponse response = await userService.getToken(uid: "yjUeHbS3iqUTuwrD0T0C8KwLieC3");
    print(response.data);
  });
}
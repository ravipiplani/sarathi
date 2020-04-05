import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/models/responses/get_token_response.dart';
import 'package:yathaarth/services/api_client.dart';

class UserService extends ApiClient {

  Future<GetTokenResponse> getToken({String idToken}) async {
    final ApiResponse response = await post("airlock/token", {
      'id_token': idToken,
    });
    return GetTokenResponse.fromJson(response.data);
  }
}
import 'package:yathaarth/services/api_client.dart';

class UserService {
  ApiClient _client = ApiClient();
  
  Future getToken({String uid}) async {
    final response = await _client.post("airlock/token", {
      "uid": uid
    });
    return response;
  }
}
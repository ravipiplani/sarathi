import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/services/api_client.dart';

class HomeService {
  ApiClient _client = ApiClient();

  Future<ApiResponse> getHomeData() async {
    final response = await _client.get("home");
    return response;
  }
}
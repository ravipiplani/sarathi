import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/models/responses/home_response.dart';
import 'package:yathaarth/services/api_client.dart';

class HomeService extends ApiClient {

  Future<List<HomeResponse>> getHomeData() async {
    final ApiResponse response = await get("home", isProtected: true);
    List<Map<dynamic, dynamic>> parsed = response.data.cast<Map<dynamic, dynamic>>().toList();
    print(parsed);
    return parsed.map((e) => HomeResponse.fromJson(e)).toList();
  }
}
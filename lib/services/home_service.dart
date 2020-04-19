import 'dart:convert';

import 'package:yathaarth/models/jsons/home_json.dart';
import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/models/responses/home/home_response.dart';
import 'package:yathaarth/services/api_client.dart';

class HomeService extends ApiClient {

  Future<HomeResponse> getHomeData() async {
    Map<String, dynamic> responseData;
    if (isEnvLocal()) {
      responseData = jsonDecode(HomeJson.getJson());
    }
    else {
      final ApiResponse response = await get("home", isProtected: true);
      responseData = response.data;
    }
    return HomeResponse.fromJson(responseData);
  }
}
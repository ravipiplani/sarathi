import 'dart:convert';

import 'package:sarathi/models/jsons/establishment_json.dart';
import 'package:sarathi/models/establishment.dart';
import 'package:sarathi/models/jsons/establishments_json.dart';
import 'package:sarathi/models/responses/api_response.dart';
import 'package:sarathi/services/api_client.dart';

class EstablishmentService extends ApiClient {

  Future<List<Establishment>> index() async {
    List<Map> responseData;

    if (isEnvLocal()) {
      responseData = jsonDecode(EstablishmentsJson.getJson()).cast<Map<String, dynamic>>();
    }
    else {
      final ApiResponse response = await get("establishments", isProtected: true);
      responseData = response.data;
    }
    return responseData.map((e) => Establishment.fromJson(e)).toList();
  }

  Future<Establishment> show({int id}) async {
    Map<String, dynamic> responseData;
    if (isEnvLocal()) {
      responseData = jsonDecode(EstablishmentJson.getJson());
    }
    else {
      final ApiResponse response = await get("establishments/$id", isProtected: true);
      responseData = response.data;
    }
    return Establishment.fromJson(responseData);
  }
}
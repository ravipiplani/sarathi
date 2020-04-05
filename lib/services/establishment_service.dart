import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/services/api_client.dart';

class EstablishmentService extends ApiClient {

  Future<ApiResponse> index({String type}) async {
    final ApiResponse response = await get("establishments?type=$type", isProtected: true);
    return response;
  }

  Future<ApiResponse> show({int id}) async {
    final ApiResponse response = await get("establishments/$id", isProtected: true);
    return response;
  }
}
import 'package:yathaarth/models/api_response.dart';
import 'package:yathaarth/services/api_client.dart';

class EstablishmentService {
  ApiClient _client = ApiClient();

  Future<ApiResponse> index({String type}) async {
    final response = await _client.get("establishments?type=$type");
    return response;
  }

  Future<ApiResponse> show({int id}) async {
    final response = await _client.get("establishments/$id");
    return response;
  }
}
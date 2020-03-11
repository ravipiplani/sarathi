import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yathaarth/exceptions/bad_request_exception.dart';
import 'package:yathaarth/exceptions/fetch_data_exception.dart';
import 'package:yathaarth/exceptions/unauthorized_exception.dart';
import 'package:yathaarth/models/api_response.dart';

class ApiClient {
  final String _baseUrl = "http://192.168.1.4/api/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer 2uRCivBCCOqOvZJUdyJar4tXZftggSWbvUUuNLmFpl4GTa8jzjMijfAF4hvmtuP2abHgIJGBUgVSlmLG"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer 2uRCivBCCOqOvZJUdyJar4tXZftggSWbvUUuNLmFpl4GTa8jzjMijfAF4hvmtuP2abHgIJGBUgVSlmLG"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = ApiResponse.fromJson(json.decode(response.body.toString()));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 422:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}
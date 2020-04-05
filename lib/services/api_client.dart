import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yathaarth/exceptions/bad_request_exception.dart';
import 'package:yathaarth/exceptions/fetch_data_exception.dart';
import 'package:yathaarth/exceptions/unauthorized_exception.dart';
import 'package:yathaarth/models/responses/api_response.dart';
import 'package:yathaarth/utils/environment_utils.dart';

class ApiClient {
  final String _baseUrl = EnvironmentUtil.getValue('API_EP');
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<ApiResponse> get(String url, {bool isProtected = false}) async {
    if (isProtected) {
      headers.addAll({'Authorization': 'Bearer ${await _getToken()}'});
    }
    ApiResponse responseJson;
    try {
      final response = await http.get(_baseUrl + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<ApiResponse> post(String url, dynamic body, {bool isProtected = false}) async {
    if (isProtected) {
      headers.addAll({'Authorization': 'Bearer ${await _getToken()}'});
    }
    ApiResponse responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<ApiResponse> put(String url, dynamic body, {bool isProtected = false}) async {
    if (isProtected) {
      headers.addAll({'Authorization': 'Bearer ${await _getToken()}'});
    }
    ApiResponse responseJson;
    try {
      final http.Response response = await http.put(_baseUrl + url, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<ApiResponse> delete(String url, {bool isProtected = false}) async {
    if (isProtected) {
      headers.addAll({'Authorization': 'Bearer ${await _getToken()}'});
    }
    ApiResponse apiResponse;
    try {
      final http.Response response = await http.delete(_baseUrl + url, headers: headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }

  Future<String> _getToken() async {
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    final String token = await _storage.read(key: 'token');
    return token;
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
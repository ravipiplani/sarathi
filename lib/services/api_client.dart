import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sarathi/models/environment.dart';
import 'package:sarathi/models/responses/api_response.dart';

class ApiClient {
  final String _baseUrl = Environment.getValue('API_EP');
  final String _appEnv = Environment.getValue('APP_ENV');
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
      throw Exception('No Internet connection');
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
      throw Exception('No Internet connection');
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
      throw Exception('No Internet connection');
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
      throw Exception('No Internet connection');
    }
    return apiResponse;
  }

  Future<String> _getToken() async {
    return 'Q4QIBPnfMTcuOFMKFlcV2IoPN17KXod5j6N5Ecl2mIDUFtR7wcqnqZqK08zceI1wYGqIMkiMYSaL1ybN';
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    final String token = await _storage.read(key: 'token');
    return token;
  }

  bool isEnvLocal() {
    return _appEnv == 'local';
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = ApiResponse.fromJson(json.decode(response.body.toString()) as Map<String, dynamic>);
        return responseJson;
      case 400:
      case 401:
      case 403:
      case 422:
      case 500:
      default:
        throw Exception('Error occured while Communication with Server with StatusCode : ${response
          .statusCode} and exception message: ${response.body.toString()}');
    }
  }
}
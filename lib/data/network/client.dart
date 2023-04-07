import 'dart:convert';
import 'dart:async';

import 'package:lettutor/data/network/constants/http_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/data/network/exceptions/network_exceptions.dart';
import 'package:lettutor/data/shared_preference/shared_preference.dart';

class RestClient {
  static RestClient? _instance;
  static RestClient get instance {
    _instance ??= RestClient._();
    return _instance!;
  }

  RestClient._();

  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = const JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path,
      {Map<String, String>? headers, Map<String, String>? params}) async {
    return http.get(Uri.https(Endpoints.baseUrl, path, params),  headers: headers).then(_createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String path,
      {Map<String, String>? headers,
      body,
      encoding,
      Map<String, String>? params}) async {
    return http
        .post(
          Uri.https(Endpoints.baseUrl, path, params),
          body: jsonEncode(body),
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .put(
          Uri.https(Endpoints.baseUrl, path),
          body: jsonEncode(body),
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }


  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .delete(
          Uri.https(Endpoints.baseUrl, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic _createResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      print("${statusCode}");
      print("${res}");
      throw NetworkException(
          message: 'Error fetching data from server', statusCode: statusCode);
    }

    return _decoder.convert(res);
  }

  // get access token

  Future<String?> getAccessToken() async {
    SharedPreference sharedPref = SharedPreference.instance;
    String? accessToken = await sharedPref.accessToken;
    return accessToken;
  }
}

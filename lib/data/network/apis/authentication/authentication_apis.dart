import 'dart:convert';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class AuthenticationApi {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> register(String email, String password) async {
    print("signUP authentication api");

    final response = await _restClient.post(Endpoints.register, headers: {
      'Content-Type': 'application/json'
    }, body: {
      'email': email,
      'password': password,
      'source': null,
    });

    return response;
  }

  Future<dynamic> logIn(String email, String password) async {
    final response = await _restClient.post(Endpoints.login, headers: {
      'Content-Type': 'application/json',
    }, body: {
      'email': email,
      'password': password,
    });
    
    return response;
  }

  Future<dynamic> loginByGoogle(String token) async {
    final response = await _restClient.post(
      Endpoints.loginByGoogle,
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'access_token': token,
      },
    );
    return response;
  }

  Future<dynamic> loginByFacebook(String token) async {
    final response = await _restClient.post(
      Endpoints.loginByFacebook,
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'access_token': token,
      },
    );
    return response;
  }
}

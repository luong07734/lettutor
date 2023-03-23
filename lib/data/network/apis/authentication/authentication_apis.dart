import 'dart:convert';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class AuthenticationApi {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> register(String email, String password) async {
    print("signUP authentication api");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response =
        await _restClient.post(Endpoints.register, headers: headers, body: {
      'email': email,
      'password': password,
      'source': null,
    });
    // print(response.toString());
    // if (response.statusCode == 201) {
    //   final Map<String, dynamic> responseData = jsonDecode(response.body);
    //   // Handle the response data
    //   return responseData;
    // } else {
    //   throw Exception('Failed to sign up: ${response.reasonPhrase}');
    // }
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
}

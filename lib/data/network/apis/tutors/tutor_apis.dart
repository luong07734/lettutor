import 'dart:convert';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class TutorApis {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> getTutorList(int page, [int perPage = 12]) async {
    final response = await _restClient.get(Endpoints.tutorList, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'perPage': perPage.toString(),
      'page': page.toString(),
    });

    return response;
  }
}

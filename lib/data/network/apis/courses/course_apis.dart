import 'dart:convert';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class CourseApi {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> getCourseList(int page, [int perPage = 6]) async {
    final response = await _restClient.get(Endpoints.courseList, headers: {
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'page': page.toString(),
      'size': perPage.toString()
    });

    return response;
  }

  Future<dynamic> searchCourse(
      int page, String? query, String? level, String? category,
      [int perPage = 100]) async {
    final params = {
      'page': page.toString(),
      'size': perPage.toString(),
    };

    if (level != null) {
      params['level[]'] = level;
    }

    if (category != null) {
      params['categoryId[]'] = category;
    }

    if (query != null) {
      params['q'] = query;
    }

    final response = await _restClient.get(Endpoints.courseList,
        headers: {
          'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
        },
        params: params);

    return response;
  }
}

import 'dart:convert';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class CourseApi{
  final RestClient _restClient = RestClient.instance;


  Future<dynamic> getCourseList(int page,
      [int perPage = 6]) async {
    final response = await _restClient.get(Endpoints.courseList,
        headers: {'Authorization': 'Bearer ${await _restClient.getAccessToken()}'},
        params: {'page': page.toString(), 'size': perPage.toString()});

    return response;
  }
  
}
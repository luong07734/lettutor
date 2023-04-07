import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';
import 'package:lettutor/models/user.dart';

class UserApis {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> updateUserInformation(UserProfile user) async {
    print("user truyen vao");
    print(user.level);
     print(user.name);
    // var birthDay = DateFormat('yyyy-MM-dd').format(user.birthday!);
    var learnTopic = user.learnTopics?.map((e) => e.id).toList();
    var testPreparations = user.testPreparations?.map((e) => e.id).toList();
    final response = await _restClient.put(Endpoints.userInfo, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, body: {
      "name": user.name,
      "country": user.country,
      "phone": user.phone,
      "birthday": user.birthday,
      "level": user.level,
      "learnTopics": learnTopic,
      "testPreparations": testPreparations,
    });
    print("after called update user info");
    print(response);

    return response;
  }

  Future<dynamic> getUserInformation() async {
    final response = await _restClient.get(Endpoints.userInfo, headers: {
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    });
    print(response);

    return response;
  }
}

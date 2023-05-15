import 'dart:io';

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';
import 'package:http/http.dart' as http;

class BecomeTutorApi {
  final RestClient _restClient = RestClient.instance;

  Future<bool> becomeTutor(
      Map<String, String> body, File video, File avatar) async {
    print("call api");
    String? token = await _restClient.getAccessToken();
    final request = http.MultipartRequest("PUT",
        Uri.parse("https://" + Endpoints.baseUrl + Endpoints.becomeTutor));

    request.fields.addAll(body);
    final img = await http.MultipartFile.fromPath("avatar", avatar.path);
    print(img);
    request.files.add(img);
    final vid = await http.MultipartFile.fromPath("video", video.path);
    print(vid);
    request.files.add(vid);
    print("request ${request}");

    request.headers.addAll({'Authorization': 'Bearer $token'});

    var response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      print("oke roi");
      print("response $response");
      return true;
    } else {
      print("fail roi");
      print("response $response");
      return false;
    }
  }
}

import 'dart:convert';

import 'package:lettutor/constants/filter.dart';
import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class TutorApis {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> getTutorList(int page, [int perPage = 12]) async {
    print("bat dau goi api");
    final accs = await _restClient.getAccessToken();
    print("${accs}");
    final response = await _restClient.get(Endpoints.tutorList, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'perPage': perPage.toString(),
      'page': page.toString(),
    });
    print("sau khi goi api");

    return response;
  }

  Future<dynamic> getTutorInformationById(String tutorId) async {
    print("bat dau goi api chi tiet tutor");
    final response = await _restClient.get('${Endpoints.tutorDetail}/$tutorId',
        headers: {
          'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
        });

    print("sau khi goi api chi tiet tutor");
    print(response);
    return response;
  }

  Future<dynamic> searchTutor(
    String keySearch, {
    int? page,
    int perPage = 12,
    List<String>? specialties,
  }) async {
    print("page ${page}");
    print("specs ${specialties}");
    final response = await _restClient.post(Endpoints.tutorSearch, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, body: {
      "page": page,
      "perPage": perPage,
      "filters": {
        "specialties": specialties ?? [],
        // "nationality":{
        //   "isNative" : true,
        //   "isVietnamese": true
        // }
      },
      "search": keySearch
    });

    return response;
  }



  Future<dynamic> addATutorToFavouriteList(String tutorId) async {
    final response =
        await _restClient.post(Endpoints.addFavoriteTutors, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, body: {
      'tutorId': tutorId
    });

    return response;
  }
}

import 'package:lettutor/data/network/client.dart';
import 'package:lettutor/data/network/constants/http_endpoints.dart';

class ScheduleApis {
  final RestClient _restClient = RestClient.instance;

  Future<dynamic> getOwnSchedule() async {
    final response = await _restClient.post(Endpoints.schedule, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    });

    return response;
  }

  // Future<dynamic> getBookedClassesFull(int page,
  //     [int perPage = 6,
  //     String orderBy = 'meeting',
  //     String sortBy = 'desc']) async {
  //   final response =
  //       await _restClient.get(Endpoints.getBookedClasses, headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
  //   }, params: {
  //     'page': page.toString(),
  //     'perPage': perPage.toString(),
  //     'orderBy': orderBy,
  //     'sortBy': sortBy
  //   });

  //   return response;
  // }

  Future<dynamic> getBookedClasses(int page, int dateTimeGte,
      [int perPage = 6,
      String orderBy = 'meeting',
      String sortBy = 'asc']) async {
    final response =
        await _restClient.get(Endpoints.getBookedClasses, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'page': page.toString(),
      'perPage': perPage.toString(),
      'dateTimeGte': dateTimeGte.toString(),
      'orderBy': orderBy,
      'sortBy': sortBy
    });

    return response;
  }

  Future<dynamic> getHistory(int page, int dateTimeLte,
      [int perPage = 6,
      String orderBy = 'meeting',
      String sortBy = 'desc']) async {
    final response =
        await _restClient.get(Endpoints.getBookedClasses, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'page': page.toString(),
      'perPage': perPage.toString(),
      'dateTimeLte': dateTimeLte.toString(),
      'orderBy': orderBy,
      'sortBy': sortBy
    });

    return response;
  }

  Future<dynamic> getSchedule(
      String tutorId, int startTimestamp, int endTimestamp) async {
    final response = await _restClient.get(Endpoints.schedule, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, params: {
      'tutorId': tutorId.toString(),
      'startTimestamp': startTimestamp.toString(),
      'endTimestamp': endTimestamp.toString()
    });

    return response;
  }

  Future<dynamic> getScheduleByTutorID(String tutorID) async {
    final response = await _restClient.post(Endpoints.scheduleByID, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, body: {
      'tutorId': tutorID
    });

    return response;
  }

  Future<dynamic> bookAClass(List<String> scheduleDetailIds,
      [String note = ""]) async {
    final response = await _restClient.post(Endpoints.bookAClass, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _restClient.getAccessToken()}'
    }, body: {
      'scheduleDetailIds': scheduleDetailIds,
      'note': note
    });

    return response;
  }
}

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "sandbox.api.lettutor.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // authenticaion endpoints
  static const String loginByGoogle = "/auth/google";
  static const String register = "/auth/register";
  static const String login = "/auth/login";

  // tutors
  static const String tutorList = "/tutor/more";
  static const String tutorDetail = "/tutor";

  // course
  static const String courseList = "/course";
}

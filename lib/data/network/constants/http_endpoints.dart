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
  static const String tutorSearch = "/tutor/search";
  static const String addFavoriteTutors = "/user/manageFavoriteTutor";

  // courses
  static const String courseList = "/course";

  // users
  static const String userInfo = "/user/info";
  static const String uploadAvatar = "/user/uploadAvatar";

  // Schedule
  static const String schedule = "/schedule";
  static const String scheduleByID = "/schedule";
  static const String getBookedClasses = "/booking/list/student";
  static const String bookAClass = "/booking";
  static const String cancelBookAClass = "/booking/schedule-detail";
  static const String updateStudentRequest = "/booking/student-request";

  // call
  static const String totalCall = "/call/total";
}

import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/courses/course_apis.dart';
import 'package:lettutor/models/course.dart';

class CourseProvider extends ChangeNotifier {
  final CourseApi _courseApis = CourseApi();
  List<CousreRowItem> _courses = [];
  int _page = 1;
  bool _hasMoreItems = true;

  List<CousreRowItem> get courses => _courses;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;

  void loadCoursesInPage({int page = 1}) {
    _page = page;

    _courseApis.getCourseList(page).then((cousres) {
      int oldLength = _courses.length;
      if (cousres["data"] != null) {
        print("load dc course");
        CoursePerPage _coursePerPage = CoursePerPage.fromJson(cousres["data"]);
        _courses += _coursePerPage.rows!;
        print("length of course: ${_courses.length}");
        if (_courses.length > oldLength) {
          _hasMoreItems = true;
        } else {
          _hasMoreItems = false;
        }
      } else {}
      notifyListeners();
    });
  }

  void reset() {
    _courses = [];
    _hasMoreItems = true;
    _page = 1;
  }
}

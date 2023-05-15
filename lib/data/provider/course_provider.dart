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
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _level;
  String? get level => _level;
  String? _category;
  String? get category => _category;
  String? _keySearch;
  String? get keySearch => _keySearch;

  void loadCoursesInPage({int page = 1}) {
    _page = page;
    _isLoading = true;

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
      _isLoading = false;
      notifyListeners();
    });
  }

  void search(String? query) {
    _keySearch = query;

    _page = 1;
    _isLoading = true;
    _courseApis.searchCourse(1, _keySearch, _level, _category).then((cousres) {
      if (cousres["data"] != null) {
        print("search dc course");
        CoursePerPage _coursePerPage = CoursePerPage.fromJson(cousres["data"]);
        _courses = _coursePerPage.rows!;
        print("length of course search: ${_courses.length}");
      } else {}
      _hasMoreItems = false;
      _isLoading = false;
      notifyListeners();
    });
  }

  void addCategory(String categoryID) {
    _category = categoryID;
    search(_keySearch);
    notifyListeners();
  }

  void addLevel(String levelId) {
    _level = levelId;
    search(_keySearch);
    notifyListeners();
  }

  void reset() {
    _courses = [];
    _hasMoreItems = true;
    _page = 1;
    _keySearch = null;
    _category = null;
    _level = null;
  }
}

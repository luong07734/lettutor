import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/tutors/tutor_apis.dart';
import 'package:lettutor/models/tutor.dart';

class TutorProvider extends ChangeNotifier {
  final TutorApis _tutorApis = TutorApis();
  List<TutorRowItem> _tutors = [];
  int _page = 1;
  bool _hasMoreItems = true;

  List<TutorRowItem> get tutors => _tutors;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;

  void loadTutorsInPage({int page = 1}) {
    _page = page;

    _tutorApis.getTutorList(page).then((tutors) {
      int oldLength = _tutors.length;
      if (tutors["tutors"] != null) {
        print("load dc");
        TutorPerPage _tutorsPerPage = TutorPerPage.fromJson(tutors);
        _tutors += _tutorsPerPage.tutors.rows;
        print("length of tutors: ${_tutors.length}");
        if (_tutors.length > oldLength) {
          _hasMoreItems = true;
        } else {
          _hasMoreItems = false;
        }
      } else {}
      notifyListeners();
    });
  }

  void reset() {
    _tutors = [];
    _hasMoreItems = true;
    _page = 1;
  }
}

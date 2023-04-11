import 'package:flutter/material.dart';
import 'package:lettutor/constants/filter.dart';
import 'package:lettutor/data/network/apis/schedule/schedule_apis.dart';
import 'package:lettutor/data/network/apis/tutors/tutor_apis.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/models/tutor_schedule.dart';

class TutorProvider extends ChangeNotifier {
  final TutorApis _tutorApis = TutorApis();
  final ScheduleApis _scheduleApis = ScheduleApis();
  List<TutorRowItem> _tutors = [];
  List<TutorRowItem> _baseTutors = [];
  List<FavoriteTutor> _favorites = [];
  int _page = 1;
  int _searchPage = 1;
  bool _hasMoreItems = true;
  List<String> _specialities = [];
  String keySearch = "";
  //schedule

  List<ScheduleOfTutor> _teacherSchedule = [];

  List<TutorRowItem> get tutors => _tutors;
  List<FavoriteTutor> get favorites => _favorites;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;
  List<String> get specialities => _specialities;
  int get searchPage => _searchPage;

  bool isFavorite(TutorRowItem tutor) {
    bool isFavorite = false;
    print(_favorites);
    for (int i = 0; i < _favorites.length; i++) {
      if (_favorites[i].secondId == tutor.userId) {
        print(i);
        isFavorite = true;
      }
    }

    print(isFavorite);
    return isFavorite;
  }

  void loadTutorsInPage({int page = 1}) {
    _page = page;

    _tutorApis.getTutorList(page).then((tutors) {
      print("getting...");
      int oldLength = _tutors.length;
      if (tutors["tutors"] != null) {
        print("load dc");
        TutorPerPage _tutorsPerPage = TutorPerPage.fromJson(tutors);
        _tutors += _tutorsPerPage.tutors.rows;
        _baseTutors += _tutorsPerPage.tutors.rows;

        _favorites = _tutorsPerPage.favoriteTutor == null
            ? []
            : _tutorsPerPage.favoriteTutor!;
        print("favorites ${_favorites}");

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

  void updateFavorite(String tutorId) {
    _tutorApis.addATutorToFavouriteList(tutorId);
    _tutorApis.getTutorList(page).then((tutors) {
      TutorPerPage _tutorsPerPage = TutorPerPage.fromJson(tutors);
      _favorites = _tutorsPerPage.favoriteTutor == null
          ? []
          : _tutorsPerPage.favoriteTutor!;
    });
    notifyListeners();
  }

  void search(String value, int page, bool isScrolled) {
    _searchPage = page;
    print("searching .....");
    keySearch = value;
    if (value.isEmpty && _specialities.isEmpty) {
      print("reloading...");
      keySearch = "";
      _tutors.clear();
      _specialities.clear();
      loadTutorsInPage(page: 1);

      notifyListeners();
      return;
    }
    var listKeySpec = <String>[];
    for (var i in specialitiesList.keys) {
      if (_specialities.contains(i)) {
        listKeySpec.add(i);
      }
    }
    print("list key spec ${listKeySpec}");

    _tutorApis
        .searchTutor(
            page: page,
            value,
            specialties: listKeySpec.isEmpty ? null : listKeySpec)
        .then((value) {
      Tutors tutors = Tutors.fromJson(value);
      int oldLength = _tutors.length;

      if (isScrolled) {
        _tutors += tutors.rows;
      } else {
        _tutors.clear();
        _tutors = tutors.rows;
        print("${tutors.rows}");
      }
      if (_tutors.length > oldLength) {
        _hasMoreItems = true;
      } else {
        _hasMoreItems = false;
      }

      notifyListeners();
    });
  }

  void reset() {
    _tutors = [];
    _hasMoreItems = true;
    _page = 1;
  }

  void addSpec(int index) {
    // if (index == 0) {
    //   _specialities.clear();
    // } else {
    _specialities.add(specialitiesList.keys.elementAt(index));
    // }

    search(keySearch, 1, false);
    print(_specialities);
  }

  void clearSpec(int index) {
    // if (index == 0) {
    // } else {
    _specialities.remove(specialitiesList.keys.elementAt(index));
    // }

    search(keySearch, 1, false);
    print(_specialities);
  }

  // schedule of tutor

  Future<void> loadScheduleOfTutor(String teacherId) async {
    print("bat dau goi api  load  schedule");
    var value = await _scheduleApis.getScheduleByTutorID(teacherId);
    _teacherSchedule.clear();
    List<ScheduleOfTutor>? schedules;
    if (value["data"] != null) {
      print("data ko null");
      schedules = value["data"]
          .map<ScheduleOfTutor>((e) => ScheduleOfTutor.fromJson(e))
          .toList();
      print("goi thang cong");
    }
    _teacherSchedule.addAll(schedules ?? []);

    notifyListeners();
  }

  Future<void> getScheduleOfTutor(String teacherId) async {
    print("bat dau goi api  load  schedule");
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int startTimestamp = today.millisecondsSinceEpoch;
// Add 6 days to the current date
    DateTime nextSixDays = today.add(Duration(days: 6));

// Set the time to 23:59:59 for the next 6 days
    DateTime endOfDay = DateTime(
        nextSixDays.year, nextSixDays.month, nextSixDays.day, 23, 59, 59);
    int endTimestamp = endOfDay.millisecondsSinceEpoch;
    var value = await _scheduleApis.getSchedule(
        teacherId, startTimestamp, endTimestamp);
    _teacherSchedule.clear();
    List<ScheduleOfTutor>? schedules;
    if (value["scheduleOfTutor"] != null) {
      print("data ko null");
      schedules = value["scheduleOfTutor"]
          .map<ScheduleOfTutor>((e) => ScheduleOfTutor.fromJson(e))
          .toList();
      print("goi thang cong");
    }
    _teacherSchedule.addAll(schedules ?? []);

    notifyListeners();
  }
}

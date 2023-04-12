import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/schedule/schedule_apis.dart';
import 'package:lettutor/models/schedule.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleApis _scheduleApis = ScheduleApis();
  List<ScheduleRowItem> _schedules = [];
  int _page = 1;
  bool _hasMoreItems = true;

  List<ScheduleRowItem> get schedules => _schedules;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;

  void loadScheduleData({int page = 1}) {
    _page = page;
    _scheduleApis.getBookedClasses(page, DateTime.now().subtract(Duration(minutes: 30)).millisecondsSinceEpoch).then((value) {
       print("getting...");
      int oldLength = _schedules.length;
      if (value["data"] != null) {
        print("load dc schedule");
        ScheduleList myScheduleList = ScheduleList.fromJson(value["data"]);
        _schedules += myScheduleList.rows!;
        print("length of schedules: ${_schedules.length}");
        if (_schedules.length > oldLength) {
          _hasMoreItems = true;
        } else {
          _hasMoreItems = false;
        }
      } else {}
      notifyListeners();
    });
  }

  void reset() {
    _schedules = [];
    _hasMoreItems = true;
    _page = 1;
  }
}

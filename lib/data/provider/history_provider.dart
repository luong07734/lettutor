import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/schedule/schedule_apis.dart';
import 'package:lettutor/models/schedule.dart';

class HistoryProvider extends ChangeNotifier{
  final ScheduleApis _scheduleApis = ScheduleApis();
  List<ScheduleRowItem> _history = [];
  int _page = 1;
  bool _hasMoreItems = true;

  List<ScheduleRowItem> get history => _history;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;


  void loadHistoryData({int page = 1}) {
    _page = page;
    _scheduleApis.getBookedClasses(page, DateTime.now().millisecondsSinceEpoch).then((value) {
       print("getting...");
      int oldLength = _history.length;
      if (value["data"] != null) {
        print("load dc schedule");
        ScheduleList myScheduleList = ScheduleList.fromJson(value["data"]);
        _history += myScheduleList.rows!;
        print("length of schedules: ${_history.length}");
        if (_history.length > oldLength) {
          _hasMoreItems = true;
        } else {
          _hasMoreItems = false;
        }
      } else {}
      notifyListeners();
    });
  }

  void reset() {
    _history = [];
    _hasMoreItems = true;
    _page = 1;
  }
}
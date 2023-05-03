import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/schedule/schedule_apis.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/models/tutor_schedule.dart';
import 'package:lettutor/view/screens/booking/components/booking_modal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isLoading = true;
  // late TutorProvider tutorProvider;
  final ScheduleApis _scheduleApis = ScheduleApis();
  List<ScheduleOfTutor> _teacherSchedule = [];
  String? tutorId;

  Future<bool> bookingTeacher(String scheduleId, String tutorId) async {
    setState(() {
      isLoading = true;
    });
    var res = await _scheduleApis.bookAClass([scheduleId]);
    if (res["data"] == null) {
      setState(() {
        isLoading = false;
      });
      return false;
    }
    _loadTutorSchedule(tutorId).then((value) {
      setState(() {
        _teacherSchedule = value;
        isLoading = false;
      });
    });
    return true;
  }

  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _context = context;
    });
  }

  @override
  void dispose() {
    _context = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    tutorId = args["tutorId"];
    print(args['tutorId']);
    if (tutorId != null) {
      _loadTutorSchedule(tutorId!).then((value) {
        setState(() {
          _teacherSchedule = value;
          isLoading = false;
        });
      });
    } else {
      _teacherSchedule = [];
      isLoading = false;
    }
  }

  static Future<List<ScheduleOfTutor>> _loadTutorSchedule(String id) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int startTimestamp = today.millisecondsSinceEpoch;
// Add 6 days to the current date
    DateTime nextSixDays = today.add(Duration(days: 6));

// Set the time to 23:59:59 for the next 6 days
    DateTime endOfDay = DateTime(
        nextSixDays.year, nextSixDays.month, nextSixDays.day, 23, 59, 59);
    int endTimestamp = endOfDay.millisecondsSinceEpoch;
    List<ScheduleOfTutor> schedules = [];
    var res =
        await ScheduleApis().getSchedule(id, startTimestamp, endTimestamp);
    if (res["scheduleOfTutor"] != null) {
      print("data ko null");

      schedules = res["scheduleOfTutor"]
          .map<ScheduleOfTutor>((e) => ScheduleOfTutor.fromJson(e))
          .toList();
      print("goi thang cong");
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.booking
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.grey[200],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: SfCalendar(
                view: CalendarView.week,
                onTap: (calendarTapDetails) {
                  if (calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                    final Appointment appointmentDetails =
                        calendarTapDetails.appointments![0];
                    // Do something with the appointment details
                    print("click ${appointmentDetails}");
                    if (appointmentDetails.color == Colors.blue) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BookingModal(
                            bookingTime: appointmentDetails.startTime
                                    .toString()
                                    .substring(0, 16) +
                                " - " +
                                appointmentDetails.endTime
                                    .toString()
                                    .substring(0, 16),
                            onBook: (notes) {
                              // Call API to book a meeting with the given notes
                              bookingTeacher(
                                      appointmentDetails.notes!, tutorId!)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value) {
                                  print("Booking sucessfully!");
                                  // ScaffoldMessenger.of(context)
                                  scaffoldMessengerKey.currentState!
                                      .showSnackBar(SnackBar(
                                    content: Center(
                                      child: Text(
                                          AppLocalizations.of(_context!)!
                                              .bookingSuccessfully),
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ));
                                } else {
                                  print("Booking failed!");
                                  scaffoldMessengerKey.currentState!
                                      .showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(
                                            AppLocalizations.of(_context!)!
                                                .bookingFailed),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              });
                            },
                          );
                        },
                      );
                    }
                  } else {
                    print("click");
                  }
                },
                dataSource: _getCalendarDataSource(),
                monthViewSettings: MonthViewSettings(showAgenda: true),
                timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: 0,
                    endHour: 24,
                    timeInterval: Duration(minutes: 25),
                    timeIntervalHeight: 80,
                    timeIntervalWidth: 80,
                    timeFormat: 'HH:mm',
                    dateFormat: 'd',
                    dayFormat: 'EEE',
                    timeRulerSize: 70),
                appointmentTextStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  _DataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    for (int i = 0; i < _teacherSchedule.length; ++i) {
      appointments.add(Appointment(
          startTime:
              DateTime.fromMillisecondsSinceEpoch(_teacherSchedule[i].startTimestamp!)
                  .toLocal(),
          endTime:
              DateTime.fromMillisecondsSinceEpoch(_teacherSchedule[i].endTimestamp!)
                  .toLocal(),
          subject: DateTime.fromMillisecondsSinceEpoch(
                      _teacherSchedule[i].startTimestamp!)
                  .toLocal()
                  .toString()
                  .substring(11, 16) +
              " - " +
              DateTime.fromMillisecondsSinceEpoch(_teacherSchedule[i].endTimestamp!)
                  .toLocal()
                  .toString()
                  .substring(11, 16),
          notes: _teacherSchedule[i].scheduleDetails![0].id,
          color: _teacherSchedule[i].isBooked == true
              ? Colors.green
              : (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
                          _teacherSchedule[i].endTimestamp!)
                      .toLocal()))
                  ? Colors.grey
                  : Colors.blue));
    }

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

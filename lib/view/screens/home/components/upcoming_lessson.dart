import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/schedule_provider.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/ultilities/meeting.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class UpcomingLessonBanner extends StatefulWidget {
  const UpcomingLessonBanner(
      {super.key, required this.schedule, required this.totalStudyTime});
  final ScheduleRowItem? schedule;
  final int totalStudyTime;

  @override
  State<UpcomingLessonBanner> createState() => _UpcomingLessonBannerState();
}

class _UpcomingLessonBannerState extends State<UpcomingLessonBanner> {
  @override
  void initState() {
    super.initState();
  }

  String formatLessonTime(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return "Total lesson time is $hours hours $remainingMinutes minutes";
  }

  @override
  Widget build(BuildContext context) {
    ScheduleRowItem? schedule = widget.schedule;
    // final ScheduleProvider scheduleHistoryDTO =
    //     context.watch<ScheduleProvider>();
    return Container(
      color: Colors.blueAccent, // màu nền của container
      width: double.infinity, // chiều rộng của container bằng toàn bộ màn hình
      padding: const EdgeInsets.symmetric(
          vertical: 40.0), // khoảng cách giữa các phần tử trong container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // canh giữa các phần tử
        children: [
          Text(
            "Upcoming lesson",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            schedule!.scheduleDetailInfo!.scheduleInfo!.date! +
                " " +
                DateTime.fromMillisecondsSinceEpoch(widget.schedule!
                        .scheduleDetailInfo!.scheduleInfo!.startTimestamp!)
                    .toLocal()
                    .toString()
                    .substring(11, 16) +
                " - " +
                DateTime.fromMillisecondsSinceEpoch(widget.schedule!
                        .scheduleDetailInfo!.scheduleInfo!.endTimestamp!)
                    .toLocal()
                    .toString()
                    .substring(11, 16),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
            ),
          ), // khoảng cách giữa tiêu đề và nút bấm
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ElevatedButton(
              onPressed: () {
                 joinJitsiMeet(context, schedule);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                elevation: 4,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              child: Text("Enter lesson room"),
            ),
          ),

          const SizedBox(height: 10.0),
          Text(
            formatLessonTime(widget.totalStudyTime),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

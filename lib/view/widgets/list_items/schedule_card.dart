import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ScheduleCard extends StatefulWidget {
  final ScheduleRowItem schedule;
  final bool isHistoryCard;
  const ScheduleCard(
      {Key? key, required this.schedule, required this.isHistoryCard})
      : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.schedule.scheduleDetailInfo!.scheduleInfo!.date!,
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("1 lesson", style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
              ],
            ),
            Card(
              child: ListTile(
                leading: (widget.schedule.scheduleDetailInfo!.scheduleInfo!
                                .tutorInfo!.avatar ==
                            null ||
                        widget.schedule.scheduleDetailInfo!.scheduleInfo!
                            .tutorInfo!.avatar!
                            .contains("icon-avatar-default.png"))
                    ? CircleAvatar(
                        backgroundImage: AssetImage(
                          AssetsManager.userAvatarImage,
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget
                            .schedule
                            .scheduleDetailInfo!
                            .scheduleInfo!
                            .tutorInfo!
                            .avatar!),
                      ),
                title: Text(
                    widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                        .name!,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(widget.schedule.scheduleDetailInfo!.scheduleInfo!
                    .tutorInfo!.country!),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text(DateTime.fromMillisecondsSinceEpoch(widget.schedule
                            .scheduleDetailInfo!.scheduleInfo!.startTimestamp!)
                        .toLocal()
                        .toString()
                        .substring(11, 16) +
                    " - " +
                    DateTime.fromMillisecondsSinceEpoch(widget.schedule
                            .scheduleDetailInfo!.scheduleInfo!.endTimestamp!)
                        .toLocal()
                        .toString()
                        .substring(11, 16)),
                trailing: widget.isHistoryCard
                    ? Text("")
                    : ElevatedButton(
                        onPressed: () {
                          // handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.white,
                          side: const BorderSide(width: 1, color: Colors.red),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cancel, color: Colors.red),
                            SizedBox(width: 8),
                            Text(AppLocalizations.of(context)!.cancel,
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            widget.isHistoryCard
                ? Card(
                    child: ListTile(
                      title: Text("No review from tutors "),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      {
                        Navigator.pushNamed(context, Routers.VideoCall);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.joinMeeting),
                  ),
          ],
        ),
      ),
    );
  }
}

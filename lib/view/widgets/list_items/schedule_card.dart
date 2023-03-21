import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

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
              children: const [
                Text("Sat, 30 April 2022",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("1 lesson", style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
              ],
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(AssetsManager.avatarImage),
                ),
                title: const Text("Keegan",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: const Text("FR"),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text("Lesson Time: 8:00 PM - 11:30 PM"),
                trailing: ElevatedButton(
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
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => VideoCallWidget(),
                //     fullscreenDialog: true,
                //   ),
                // );
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

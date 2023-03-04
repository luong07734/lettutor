import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetsManager.scheduleImage,
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            "Schedule",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Here is a lisst of the sessions you have bookeed. \nYou can track when the meeeting starts, join the meeting with one click or can cancel the meeting before 2 hours.",
                textAlign: TextAlign.start,
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 5.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sat, 30 April 2022",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("1 lesson", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 16),
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetsManager.avatarImage),
                          ),
                          title: Text("Keegan",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text("FR"),
                        ),
                      ),
                      SizedBox(height: 16),
                      Card(
                        child: ListTile(
                          title: Text("Lesson Time: 8:00 PM - 11:30 PM"),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // handle button press
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.red,
                              side: BorderSide(width: 1, color: Colors.red),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cancel, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Cancel',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Join Meeting"),
                      ),
                    ],
                  ),
                ),
              );
              ;
            },
          ),
        ),
      ],
    );
  }
}

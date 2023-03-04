import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetsManager.historyImage,
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            "History",
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
                "The following is a list of lessons you have attended. \nYou can review the details of the lessens youu have attended.",
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
                        ),
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

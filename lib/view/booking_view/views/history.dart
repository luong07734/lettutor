import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                AssetsManager.historyImage,
                width: 100,
                height: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "The following is a list of lessons you have attended. \nYou can review the details of the lessens youu have attended.",
                    textAlign: TextAlign.start,
                  ),
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
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
                        const Text("Sat, 30 April 2022",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text("4 hours ago",
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(AssetsManager.avatarImage),
                            ),
                            title: const Text("Keegan",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            subtitle: const Text("FR"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Card(
                          child: ListTile(
                            title: Text("Lesson Time: 8:00 PM - 11:30 PM"),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Card(
                          child: ListTile(
                            title: Text("No review from tutors "),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

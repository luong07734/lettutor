import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/widgets/list_items/schedule_card.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              AssetsManager.scheduleImage,
              width: 100,
              height: 100,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                    width: 5.0,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Here is a lisst of the sessions you have bookeed. \nYou can track when the meeeting starts, join the meeting with one click or can cancel the meeting before 2 hours.",
                  textAlign: TextAlign.start,
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
              return const ScheduleCard();
            },
          ),
        ],
      ),
    );
  }
}

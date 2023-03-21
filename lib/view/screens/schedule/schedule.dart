import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/widgets/list_items/schedule_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SchedulePage extends StatelessWidget {
  static String routeName = "/schedule";
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              AppLocalizations.of(context)!.schedule,
              style: const TextStyle(
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
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.scheduleDescription,
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

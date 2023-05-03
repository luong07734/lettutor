import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/schedule_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/schedule_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    print("init schedule called");

    // fetch initial teacher data
    context.read<ScheduleProvider>().reset();
    context.read<ScheduleProvider>().loadScheduleData();

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<ScheduleProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      print("scrolled max");
      // fetch next page of teacher data

      provider.loadScheduleData(page: provider.page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
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
          Consumer<ScheduleProvider>(builder: (context, scheduleProvider, _) {
            if (scheduleProvider.schedules.isEmpty &&
                !scheduleProvider.isLoading) {
              // show "No Schedule" message
              return Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      AssetsManager.searchNotFoundImage,
                      width: 160,
                      height: 160,
                    ),
                  ),
                  ProfileDescription(
                      text: AppLocalizations.of(context)!.noSchedule),
                ],
              ));
            } else if (scheduleProvider.isLoading) {
              // show loading indicator while data is being fetched
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // controller: _scrollController,
                itemCount: scheduleProvider.schedules.length +
                    ((scheduleProvider.hasMoreItems &&
                            scheduleProvider.schedules.length >= 3)
                        ? 1
                        : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < scheduleProvider.schedules.length) {
                    final schedule = scheduleProvider.schedules[index];
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), // Màu bóng đổ
                            spreadRadius: 1, // Bán kính của bóng đổ
                            blurRadius: 1, // Độ mờ của bóng đổ
                            offset: const Offset(
                                0, 1), // Độ dịch chuyển của bóng đổ
                          ),
                        ],
                      ),
                      // child: TeacherCard(index, context, tutor),
                      child: ScheduleCard(
                        schedule: schedule,
                        isHistoryCard: false,
                      ),
                    );
                  } else {
                    // show loading indicator at end of list
                    if (scheduleProvider.hasMoreItems) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              );
            }
          }),
        ],
      ),
    );
  }
}

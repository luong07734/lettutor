import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/history_provider.dart';
import 'package:lettutor/view/widgets/list_items/schedule_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    print("init history called");

    // fetch initial teacher data
    context.read<HistoryProvider>().reset();
    context.read<HistoryProvider>().loadHistoryData();

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<HistoryProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      print("scrolled max");
      // fetch next page of teacher data

      provider.loadHistoryData(page: provider.page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scheduleHistory),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                AppLocalizations.of(context)!.scheduleHistory,
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
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.historyDescription,
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
            Consumer<HistoryProvider>(builder: (context, historyProvider, _) {
              if (historyProvider.history.isEmpty &&
                  !historyProvider.isLoading) {
                // show "No Schedule" message
                return Center(child: Text("No History"));
              } else if (historyProvider.isLoading) {
                // show loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // controller: _scrollController,
                  itemCount: historyProvider.history.length +
                      ((historyProvider.hasMoreItems &&
                              historyProvider.history.length >= 3)
                          ? 1
                          : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < historyProvider.history.length) {
                      final schedule = historyProvider.history[index];
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.1), // Màu bóng đổ
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
                          isHistoryCard: true,
                        ),
                      );
                    } else {
                      // show loading indicator at end of list
                      if (historyProvider.hasMoreItems) {
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/course_provider.dart';
import 'package:lettutor/data/provider/schedule_provider.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/home/components/upcoming_lessson.dart';
import 'package:lettutor/view/widgets/list_items/course_card.dart';
import 'package:lettutor/view/widgets/list_items/tutor_card.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.moveAtIndex, Key? key}) : super(key: key);

  final Function(int index) moveAtIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TutorProvider>().reset();
    context.read<TutorProvider>().loadTutorsInPage();
    context.read<CourseProvider>().reset();
    context.read<CourseProvider>().loadCoursesInPage();
    context.read<ScheduleProvider>().reset();
    context.read<ScheduleProvider>().loadScheduleData();
    context.read<ScheduleProvider>().loadTotalStudyTime();
  }

  String formatLessonTime(int minutes) {
    print("minutes ${minutes}");
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return AppLocalizations.of(context)!
        .totalLessonTime(hours, remainingMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Provider.of<ScheduleProvider>(context).schedules.isNotEmpty
              ? UpcomingLessonBanner(
                  schedule: Provider.of<ScheduleProvider>(context).schedules[0],
                  totalStudyTime:
                      Provider.of<ScheduleProvider>(context).totalStudyTime,
                )
              : Container(
                  color: Colors.blueAccent, // màu nền của container
                  width: double
                      .infinity, // chiều rộng của container bằng toàn bộ màn hình
                  padding: const EdgeInsets.symmetric(
                      vertical:
                          40.0), // khoảng cách giữa các phần tử trong container
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // canh giữa các phần tử
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 20.0), // khoảng cách giữa tiêu đề và nút bấm
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.moveAtIndex(2);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            elevation: 4,
                            textStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          child: Text(AppLocalizations.of(context)!.bookLesson),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        formatLessonTime(Provider.of<ScheduleProvider>(context)
                            .totalStudyTime),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.recommendTutors,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Chữ in đậm
                    fontSize: 16.0, // Cỡ chữ 16
                    decoration: TextDecoration.underline, // Gạch chân
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.moveAtIndex(2);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            width: double.infinity,
            child:
                Consumer<TutorProvider>(builder: (context, tutorProvider, _) {
              if (tutorProvider.tutors.isEmpty) {
                // show loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tutorProvider.tutors.length,
                  itemBuilder: (BuildContext context, int index) {
                    final tutor = tutorProvider.tutors[index];
                    return Container(
                      width: 360,
                      height: 250,
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
                      child:
                          // TeacherCard(index, context, tutor),
                          GestureDetector(
                        onTap: () {
                          {
                            Navigator.pushNamed(context, Routers.TeacherDetail,
                                arguments: {
                                  'tutor': tutor,
                                });
                          }
                          ;
                        },
                        child: TutorCard(
                          tutor: tutor,
                          isFavorite: tutorProvider.isFavorite(tutor),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.recommendCourses,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Chữ in đậm
                    fontSize: 16.0, // Cỡ chữ 16
                    decoration: TextDecoration.underline, // Gạch chân
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.moveAtIndex(3);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 260,
            width: double.infinity,
            child:
                Consumer<CourseProvider>(builder: (context, courseProvider, _) {
              if (courseProvider.courses.isEmpty) {
                // show loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: courseProvider.courses.length,
                    // gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   childAspectRatio: 3.8 / 5,
                    // ),
                    itemBuilder: (BuildContext context, int index) {
                      final course = courseProvider.courses[index];
                      return Container(
                        width: 190,
                        height: 300,
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
                        child: GestureDetector(
                            onTap: (() {
                              Navigator.pushNamed(context, Routers.CourseDetail,
                                  arguments: {
                                    'course': course,
                                  });
                            }),
                            child: CourseCard(
                              index: index,
                              course: course,
                            )),
                      );
                    });
              }
            }),
          )
        ],
      ),
    );
  }
}

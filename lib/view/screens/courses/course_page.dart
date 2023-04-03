import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/course_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/course_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    print("init courses called");

    // fetch initial teacher data
    context.read<CourseProvider>().reset();
    context.read<CourseProvider>().loadCoursesInPage();

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<CourseProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // fetch next page of teacher data
      provider.loadCoursesInPage(page: provider.page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchCourses,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child:
              Consumer<CourseProvider>(builder: (context, courseProvider, _) {
            if (courseProvider.courses.isEmpty) {
              // show loading indicator while data is being fetched
              return CircularProgressIndicator();
            } else {
              return GridView.builder(
                  controller: _scrollController,
                  itemCount: courseProvider.courses.length +
                      (courseProvider.hasMoreItems ? 2 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.8 / 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < courseProvider.courses.length) {
                      final course = courseProvider.courses[index];
                      return GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(context, Routers.CourseDetail,
                                arguments: {
                                  'course': course,
                                });
                          }),
                          child: CourseCard(
                            index: index,
                            course: course,
                          ));
                    } else {
                      if (courseProvider.hasMoreItems) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Container();
                      }
                    }
                  });
            }
          }),
        )
      ],
    );
  }
}

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
  final _searchController = TextEditingController(); // Add this line
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    print("init courses called");

    // fetch initial teacher data
    context.read<CourseProvider>().reset();
    context.read<CourseProvider>().loadCoursesInPage();

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);

    // add listener for text field changes
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
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
            controller: _searchController, // Add this line
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
              final filteredCourses = courseProvider.courses
                  .where((course) =>
                      course.name!.toLowerCase().contains(_searchQuery))
                  .toList();

              return filteredCourses.length == 0
                  ? Center(child: Text("No result"))
                  : GridView.builder(
                      controller: _scrollController,
                      itemCount: filteredCourses.length +
                          ((courseProvider.hasMoreItems &&
                                  filteredCourses.length >= 4)
                              ? 2
                              : 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.8 / 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < filteredCourses.length) {
                          final course = filteredCourses[index];
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.1), // Màu bóng đổ
                                  spreadRadius: 1, // Bán kính của bóng đổ
                                  blurRadius: 1, // Độ mờ của bóng đổ
                                  offset: const Offset(
                                      0, 1), // Độ dịch chuyển của bóng đổ
                                ),
                              ],
                            ),
                            child: GestureDetector(
                                onTap: (() {
                                  Navigator.pushNamed(
                                      context, Routers.CourseDetail,
                                      arguments: {
                                        'course': course,
                                      });
                                }),
                                child: CourseCard(
                                  index: index,
                                  course: course,
                                )),
                          );
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

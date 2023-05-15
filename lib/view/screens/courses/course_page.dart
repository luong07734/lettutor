import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/course_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/course_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController(); // Add this line
  String _selectedOption = "";
  String _selectedFilter = "";
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
        // _searchQuery = _searchController.text.toLowerCase();
        context
            .read<CourseProvider>()
            .search(_searchController.text.toLowerCase());
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
      if (provider.keySearch == null &&
          provider.category == null &&
          provider.level == null) {
        provider.loadCoursesInPage(page: provider.page + 1);
      } else {}
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
        Row(
          children: [
            SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: null,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    context.read<CourseProvider>().addLevel(value);
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  hintText: AppLocalizations.of(context)!.selectLevel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.level,
                  prefixIcon: Icon(Icons.sort),
                ),
                items: [
                  DropdownMenuItem(
                    value: '0',
                    child: Text(
                      'Any Level',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '1',
                    child: Text(
                      'Beginner',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text(
                      'Upper-Beginner',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text(
                      'Pre-Intermediate',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text(
                      'Intermediate',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text(
                      'Upper-Intermediate',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '6',
                    child: Text(
                      'Pre-advanced',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '7',
                    child: Text(
                      'Advanced',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true, // Expand the dropdown to fit the content
                value: null,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                    context.read<CourseProvider>().addCategory(value);
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  hintText: AppLocalizations.of(context)!.selectCategory,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  labelText: AppLocalizations.of(context)!.category,
                  prefixIcon: Icon(Icons.sort),
                ),
                items: [
                  DropdownMenuItem(
                    value: '968e7e18-10c0-4742-9ec6-6f5c71c517f5',
                    child: Text(
                      'For studying abroad',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'd95b69f7-b810-4cdf-b11d-49faaa71ff4b',
                    child: Text(
                      'English for Traveling',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'c4e7f418-4006-40f2-ba13-cbade54c1fd0',
                    child: Text(
                      'Conversational English',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '488cc5f8-a5b1-45cd-8d3a-47e690f9298e',
                    child: Text(
                      'English for Beginners',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'f01cf003-25d1-432f-aaab-bf0e8390e14f',
                    child: Text(
                      'Business English',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '975f83f6-30c5-465d-8d98-65e4182369ba',
                    child: Text(
                      'STARTERS',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'fb92cf24-1736-4cd7-a042-fa3c37921cf8',
                    child: Text(
                      'English for Kid',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '0b89ead7-0e92-4aec-abce-ecfeba10dea5',
                    child: Text(
                      'PET',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '248ca9f5-b46d-4a55-b81c-abafebff5876',
                    child: Text(
                      'KET',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '534a94f1-579b-497d-b891-47d8e28e1b2c',
                    child: Text(
                      'MOVERS',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'df9bd876-c631-413c-9228-cc3d6a5c34fa',
                    child: Text(
                      'FLYERS',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'd87de7ba-bd4c-442c-8d58-957acb298f57',
                    child: Text(
                      'TOEFL',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '1e662753-b305-47ad-a319-fa52340f5532',
                    child: Text(
                      'TOEIC',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '255c96b6-fd6f-4f43-8dbd-fec766e361e0',
                    child: Text(
                      'IELTS',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        SizedBox(height: 8),
        Flexible(
          child:
              Consumer<CourseProvider>(builder: (context, courseProvider, _) {
            if (courseProvider.courses.isEmpty && !courseProvider.isLoading) {
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
                      text: AppLocalizations.of(context)!.searchNotFound),
                ],
              ));
            } else if (courseProvider.isLoading) {
              // final filteredCourses = courseProvider.courses
              //     .where((course) =>
              //         course.name!.toLowerCase().contains(_searchQuery))
              //     .toList();
              return Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                  controller: _scrollController,
                  itemCount: courseProvider.courses.length +
                      ((courseProvider.hasMoreItems &&
                              courseProvider.courses.length >= 4)
                          ? 2
                          : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.8 / 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < courseProvider.courses.length) {
                      final course = courseProvider.courses[index];
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

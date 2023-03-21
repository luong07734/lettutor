import 'package:flutter/material.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/course_card.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CoursePage extends StatelessWidget {
  static String routeName = "/courses";
  CoursePage({super.key});
  final List<Map<String, String>> _items = [
    {
      'title': 'English Conversation 10222 edqweed edeq qedwqdqdw wqdd',
      'subtitle1':
          'Even more approachable lessons for absolute person lorem ipsum ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
    {
      'title': 'English Conversation 102',
      'subtitle1': 'Even more approachable lessons for absolute ',
      'subtitle2': 'Intermediate · 10 lessons',
      'image': 'https://picsum.photos/200/300'
    },
  ];

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
          child: GridView.builder(
              itemCount: _items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.8 / 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: (() {
                      Navigator.pushNamed(context, Routers.CourseDetail);
                    }),
                    child: CourseCard(
                      index: index,
                      items: _items,
                    ));
              }),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lettutor/view/screens/course_detail/course_detail.dart';
import 'package:lettutor/view/widgets/list_items/course_card.dart';

class CoursePage extends StatelessWidget {
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
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search Courses",
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CourseDetail(),
                        ),
                      );
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

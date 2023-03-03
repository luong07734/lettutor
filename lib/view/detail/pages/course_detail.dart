import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/detail/components/profile_description.dart';
import 'package:lettutor/view/detail/components/profile_title.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      AssetsManager.courseImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Life in the Internet Age',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Let's discuss how technology is changing the way we live",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Intermediate . 9 Lessons',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const ProfileTitle(text: "Overview"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.circleIconColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'Why take this course?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileDescription(
              text:
                  "Our world is rapidly changing thanks to new technology , and the vocabulary nededed to discuss modern life is evolving almost daily. In this course you will learn the most up-tio-date terminology from experly crafted lessons as well from your native-speaking tutor."),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.circleIconColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'What will you be able to do?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileDescription(
            text:
                "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discuss questions, you will practise intermediate level speakking tasks such as using data to describe trends.",
          ),
          const SizedBox(
            height: 10,
          ),
          const ProfileTitle(text: "Experience Level"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.people,
                  color: ColorsManager.circleIconColor,
                ),
              ),
              const Text(
                'Intermediate',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const ProfileTitle(text: "Course Length"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.book,
                  color: ColorsManager.circleIconColor,
                ),
              ),
              const Text(
                '9',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const ProfileTitle(text: "List Topics"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  10, // Replace this with the actual number of items you want to display
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '1. Social Media',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/constants/fake_data.dart';
import 'package:lettutor/view/authentication/components/custom_button.dart';
import 'package:lettutor/view/detail/components/comment_card.dart';
import 'package:lettutor/view/detail/components/profile_description.dart';
import 'package:lettutor/view/detail/components/profile_title.dart';
import 'package:lettutor/view/detail/components/rating.dart';
import 'package:lettutor/view/detail/components/video_player.dart';
import 'package:lettutor/view/main_feature/components/teacher_card.dart';
import 'package:video_player/video_player.dart';

class TeacherDetail extends StatelessWidget {
  TeacherDetail({super.key});

  List<Widget> buttonList = [
    ElevatedButton(
      onPressed: () {},
      child: Text('Button 1'),
    ),
    ElevatedButton(
      onPressed: () {},
      child: Text('Button 2'),
    ),
    ElevatedButton(
      onPressed: () {},
      child: Text('Button 3'),
    ),
  ];

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Pick your date!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        'Fri, 29 April 2022, 08:00 PM',
                        textAlign: TextAlign.center,
                      ),
                      leading: Icon(Icons.date_range),
                      onTap: () {
                        // Handle button press
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoPlayerWidget(
            videoUrl:
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AssetsManager.avatarImage),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Abby",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Teacher",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Phillipines (The)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingWidget('2.5'),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      label: const Text('Like'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomButton(
              onTap: () {
                _showModalBottomSheet(context);
              },
              text: 'Booking'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // canh giữa dòng
            children: [
              InkWell(
                onTap: () {
                  // do something when button is tapped
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.message, color: ColorsManager.primaryColor),
                    const SizedBox(height: 8.0),
                    Text(
                      'Message',
                      style: TextStyle(color: ColorsManager.primaryColor),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // do something when button is tapped
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.report, color: ColorsManager.primaryColor),
                    const SizedBox(height: 8.0),
                    Text(
                      'Report',
                      style: TextStyle(color: ColorsManager.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'I was teaching for 3 years as an ESL teacher I am Tesol certified, I teach kids, adult and professionals. I make sure my class is students-centered. I will help you with  your english goal.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ProfileTitle(text: "Languages"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 4.0,
              children: List.generate(3, (chipIndex) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Chip(
                    label: Text('English'),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }),
            ),
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   itemCount: chipTitles.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 8.0),
          //       child: Chip(
          //         label: Text(
          //           chipTitles[index],
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         backgroundColor: chipColors[index % chipColors.length],
          //       ),
          //     );
          //   },
          // ),
          ProfileTitle(text: "Education"),
          ProfileDescription(
              text:
                  "Bachelor Of Elementary education at Stratford International School"),
          ProfileTitle(text: "Experience"),
          ProfileDescription(
              text:
                  "I have 3 years teaching experience both kids and adult as a classroom teacher adn as an ESL Teacher in Vietnam in public schools and centers."),
          ProfileTitle(text: "Interests"),
          ProfileDescription(
              text:
                  "Traveling, reading, watching movies, learn foreign language"),
          ProfileTitle(text: "Profession"),
          ProfileDescription(text: "Teacher"),
          ProfileTitle(text: "Specialities"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 4.0,
              children: List.generate(3, (chipIndex) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Chip(
                    label: Text('English'),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }),
            ),
          ),
          ProfileTitle(text: "Course"),
          ProfileTitle(text: "Rating and Comment"),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return CommentCard();
            },
          ),
        ],
      ),
    );
  }
}

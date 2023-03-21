import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/constants/fake_data.dart';
import 'package:lettutor/view/widgets/view_items/buttons/custom_button.dart';
import 'package:lettutor/view/widgets/list_items/comment_card.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:lettutor/view/widgets/view_items/rating/rating.dart';
import 'package:lettutor/view/screens/tutor_detail/components/video_player.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherDetailPage extends StatelessWidget {
  static String routeName = "/teacher_detail";
  TeacherDetailPage({super.key});

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: const Text(
                  'Pick your date!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: const Text(
                        'Fri, 29 April 2022, 08:00 PM',
                        textAlign: TextAlign.center,
                      ),
                      leading: const Icon(Icons.date_range),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Detail'),
      ),
      body: SingleChildScrollView(
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
                      padding: const EdgeInsets.only(left: 4),
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
                        label: Text(AppLocalizations.of(context)!.like),
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
                text: AppLocalizations.of(context)!.booking),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // canh giữa dòng
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
                        AppLocalizations.of(context)!.message,
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
                        AppLocalizations.of(context)!.report,
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
            ProfileTitle(text: AppLocalizations.of(context)!.languages),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Wrap(
            //     spacing: 4.0,
            //     children: List.generate(3, (chipIndex) {
            //       return const Padding(
            //         padding: EdgeInsets.only(top: 4.0),
            //         child: CustomChip(label: "English", clickable: false),
            //       );
            //     }),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: chipTitles.length,
                  itemBuilder: (context, subIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomChip(
                        label: chipTitles[subIndex],
                        clickable: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            ProfileTitle(text: AppLocalizations.of(context)!.education),
            const ProfileDescription(
                text:
                    "Bachelor Of Elementary education at Stratford International School"),
            ProfileTitle(text: AppLocalizations.of(context)!.experience),
            const ProfileDescription(
                text:
                    "I have 3 years teaching experience both kids and adult as a classroom teacher adn as an ESL Teacher in Vietnam in public schools and centers."),
            ProfileTitle(text: AppLocalizations.of(context)!.interest),
            const ProfileDescription(
                text:
                    "Traveling, reading, watching movies, learn foreign language"),
            ProfileTitle(text: AppLocalizations.of(context)!.profession),
            const ProfileDescription(text: "Teacher"),
            ProfileTitle(text: AppLocalizations.of(context)!.specialities),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Wrap(
            //     spacing: 4.0,
            //     children: List.generate(3, (chipIndex) {
            //       return const Padding(
            //         padding: EdgeInsets.only(top: 4.0),
            //         child:
            //             CustomChip(label: "English for kids", clickable: false),
            //       );
            //     }),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: chipTitles.length,
                  itemBuilder: (context, subIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomChip(
                        label: chipTitles[subIndex],
                        clickable: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            ProfileTitle(text: AppLocalizations.of(context)!.rating),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const CommentCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}

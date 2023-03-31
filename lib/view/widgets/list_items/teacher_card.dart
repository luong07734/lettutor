import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/view_items/rating/rating.dart';
import 'package:lettutor/view/screens/tutor_detail/teacher_detail.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';

import '../../../constants/asset_manager.dart';
import '../../../constants/fake_data.dart';

GestureDetector TeacherCard(
    int index, BuildContext context, TutorRowItem tutor) {
  final List<String> specialities = tutor.specialties!.split(",");

  String toUpperCase(String word) {
    List<String> words = word.split('-');
    String result = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
    return result;
  }

  double calRating() {
    int sum = 0;
    if (tutor.feedbacks!.length == 0) {
      return -1;
    }
    for (int i = 0; i < tutor.feedbacks!.length; ++i) {
      sum += tutor.feedbacks![i].rating!;
    }
    double result =
        double.parse((sum / tutor.feedbacks!.length).toStringAsFixed(1));
    return result;
  }

  return GestureDetector(
    onTap: () {
      {
        Navigator.pushNamed(context, Routers.TeacherDetail);
      }
      ;
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15), // adjust the border radius to control the tile's roundness
        ),
        child: Column(
          children: [
            ListTile(
              leading: (tutor.avatar == null || tutor.avatar!.contains("icon-avatar-default.png"))
                  ? CircleAvatar(
                      backgroundImage: AssetImage(
                        AssetsManager.userAvatarImage,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(tutor.avatar!),
                    ),
              title: Text(tutor.name.toString()),
              subtitle: Row(
                children: [
                  calRating() == -1
                      ? Text("No reviews yet")
                      : RatingWidget(calRating().toString()),
                ],
              ),
              trailing: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                label: const Text('Like'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: specialities.length,
                  itemBuilder: (context, subIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomChip(
                        label: toUpperCase(specialities[subIndex]),
                        clickable: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                tutor.bio.toString(),
                textAlign: TextAlign.start,
                maxLines: 4,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:lettutor/view/detail/components/rating.dart';
import 'package:lettutor/view/detail/pages/teacher_detail.dart';
import 'package:lettutor/view/main_feature/components/custom_chip.dart';

import '../../../constants/asset_manager.dart';
import '../../../constants/fake_data.dart';

GestureDetector TeacherCard(int index, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TeacherDetail(),
        ),
      );
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
              leading: CircleAvatar(
                backgroundImage: AssetImage(AssetsManager.avatarImage),
              ),
              title: Text(myData[index]['name'].toString()),
              subtitle: Row(
                children: [
                  RatingWidget(myData[index]['rating'].toString()),
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
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                myData[index]['description'].toString(),
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

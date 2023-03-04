import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/detail/components/rating.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(AssetsManager.avatarImage),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "LE KY LUONG",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RatingWidget("4.5"),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "He is a great tracher who I have studied. I am very admire her. Luvvvvvv",
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Mon, 2 Aug 2021, 02:06",
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/view/widgets/view_items/rating/rating.dart';

class CommentCard extends StatefulWidget {
  final FeedBack feedBack;
  const CommentCard({Key? key, required this.feedBack}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
 
  String formatDate(String date) {
    //  print("before ${date}");
    return date.substring(0, 10) + " " + date.substring(11, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.feedBack.firstInfo!.avatar == null ||
                    widget.feedBack.firstInfo!.avatar!
                        .contains("icon-avatar-default.png") ||
                    widget.feedBack.firstInfo!.avatar!
                        .contains("https://platform-lookaside.fbsbx.com/"))
                ? CircleAvatar(
                    backgroundImage: AssetImage(
                      AssetsManager.userAvatarImage,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.feedBack.firstInfo!.avatar!),
                  ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.feedBack.firstInfo!.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingWidget(double.parse(widget.feedBack.rating.toString())
                      .toStringAsFixed(1)
                      .toString()),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.feedBack.content!,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatDate(widget.feedBack.createdAt!),
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

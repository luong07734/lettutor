import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';
import 'package:lettutor/view/widgets/view_items/rating/rating.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class TutorCard extends StatefulWidget {
  final TutorRowItem tutor;
  final bool isFavorite;
  const TutorCard({super.key, required this.tutor, required this.isFavorite});

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  bool? isFavorite;
  @override
  void initState() {
    super.initState();

    isFavorite = widget.isFavorite;
  }

  String toUpperCase(String word) {
    List<String> words = word.split('-');
    String result = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
    return result;
  }

  double calRating() {
    int sum = 0;
    if (widget.tutor.feedbacks == null || widget.tutor.feedbacks!.length == 0) {
      return -1;
    }
    for (int i = 0; i < widget.tutor.feedbacks!.length; ++i) {
      sum += widget.tutor.feedbacks![i].rating!;
    }
    double result =
        double.parse((sum / widget.tutor.feedbacks!.length).toStringAsFixed(1));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> specialities = widget.tutor.specialties!.split(",");
    return Padding(
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
              leading: (widget.tutor.avatar == null ||
                      widget.tutor.avatar!.contains("icon-avatar-default.png"))
                  ? CircleAvatar(
                      backgroundImage: AssetImage(
                        AssetsManager.userAvatarImage,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(widget.tutor.avatar!),
                    ),
              title: Text(widget.tutor.name.toString()),
              subtitle: Row(
                children: [
                  widget.tutor.rating == null
                      ? Text("No reviews yet")
                      : RatingWidget(
                          double.parse(widget.tutor.rating.toString())
                              .toStringAsFixed(1)
                              .toString()),
                ],
              ),
              trailing:
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.favorite_border),
                  //   label: const Text('Like'),
                  // ),
                  TextButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite!;

                    // TODO: change favorite
                  });
                  context.read<TutorProvider>().updateFavorite(widget.tutor.userId!);
                },
                icon: isFavorite!
                    ? const Icon(Icons.favorite_outlined, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                label: Text(
                  AppLocalizations.of(context)!.like,
                  style: TextStyle(
                    color: isFavorite! ? Colors.red : null,
                  ),
                ),
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
                        index: -1,
                        selected: true,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.tutor.bio.toString(),
                textAlign: TextAlign.start,
                maxLines: 4,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

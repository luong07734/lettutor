import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/models/course.dart';

class CourseCard extends StatelessWidget {
  final int index;
  final CousreRowItem course;
  const CourseCard({super.key, required this.index, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridTile(
        child: Card(
          elevation: 4, // adjust the elevation to control the shadow depth
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15), // adjust the border radius to control the tile's roundness
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                height: 92,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    course.imageUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(AssetsManager.imageLoadFailedImage);
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  course.name!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  course.description!,
                  // style: const TextStyle(
                  //   color: Colors.black87,
                  // ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level " +
                          course.level! +
                          " · " +
                          course.topics!.length.toString() +
                          " lessons",
                      style: TextStyle(
                        color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

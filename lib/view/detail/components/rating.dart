import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String text;

  RatingWidget(this.text);

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(text);
    print(rating);
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            i < rating
                ? Icons.star
                : (i - rating < 1 ? Icons.star_half : Icons.star_border),
            color: i < rating
                ? Colors.yellow
                : (i - rating < 1 ? Colors.yellow : Colors.grey),
          ),
        SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}

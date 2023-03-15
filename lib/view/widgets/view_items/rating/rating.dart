import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String text;

  RatingWidget(this.text, {super.key});

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
                ? Colors.yellow[600]
                : (i - rating < 1 ? Colors.yellow[600] : Colors.grey[300]),
          ),
        const SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}

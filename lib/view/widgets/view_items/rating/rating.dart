import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String text;

  RatingWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(text);
    double tolerance = .001;
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            i < rating + tolerance
                ? Icons.star
                : (i - (rating - tolerance) < 1
                    ? Icons.star_half
                    : Icons.star_border),
            color: i < (rating + tolerance)
                ? Colors.yellow[600]
                : (i - (rating - tolerance) < 1
                    ? Colors.yellow[600]
                    : Colors.grey[300]),
          ),
        const SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}

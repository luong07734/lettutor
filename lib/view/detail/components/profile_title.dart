import 'package:flutter/material.dart';

class ProfileTitle extends StatelessWidget {
  final String text;

  const ProfileTitle({Key? key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue, // set the color of the text
          fontSize: 20, // set the font size of the text
          fontWeight: FontWeight.bold, // set the font weight of the text
        ),
      ),
    );
  }
}

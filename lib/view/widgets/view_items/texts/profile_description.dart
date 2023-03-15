import 'package:flutter/material.dart';

class ProfileDescription extends StatelessWidget {
  final String text;

  const ProfileDescription({Key? key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0, // adjust the font size as needed
        ),
      ),
    );
  }
}

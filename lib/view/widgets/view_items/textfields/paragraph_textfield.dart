import 'package:flutter/material.dart';

class ParagraphTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;

  const ParagraphTextField(
      {super.key, required this.title, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: title,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}

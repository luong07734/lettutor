import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  final String hint;

  FormTextField(
      {required this.title, required this.icon, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: Icon(icon),
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

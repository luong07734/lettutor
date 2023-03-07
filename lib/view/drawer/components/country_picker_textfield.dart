import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';

class FlagTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hint;

  FlagTextFormField(
      {required this.title, required this.controller, required this.hint});
  @override
  _FlagTextFormFieldState createState() => _FlagTextFormFieldState();
}

class _FlagTextFormFieldState extends State<FlagTextFormField> {
  String _selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              onSelect: (Country country) {
                setState(() {
                  _selectedCountry = country.name;
                  widget.controller.text = _selectedCountry;
                });
              },
            );
          },
          child: Icon(Icons.flag_outlined),
        ),
        labelText: widget.title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      readOnly: true,
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country.name;
              widget.controller.text = _selectedCountry;
            });
          },
        );
      },
    );
  }
}

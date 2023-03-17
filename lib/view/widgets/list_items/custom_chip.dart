import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final bool clickable;
  const CustomChip({super.key, required this.label, required this.clickable});

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.label),
      backgroundColor:
          (isSelected || !widget.clickable) ? Colors.blue : Colors.grey,
      selectedColor: Colors.blue,
      labelStyle: (isSelected || !widget.clickable)
          ? const TextStyle(color: Colors.white)
          : null,
      onSelected: (bool selected) {
        if (widget.clickable) {
          setState(() {
            isSelected = selected;
          });
        }
      },
      selected: isSelected,
    );
  }
}

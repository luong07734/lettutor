import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:provider/provider.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final bool clickable;
  final int index;
  final bool selected;
  const CustomChip(
      {super.key,
      required this.label,
      required this.clickable,
      required this.index,
      required this.selected});

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = widget.selected;
  }

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
          if (selected) {
            context.read<TutorProvider>().addSpec(widget.index);
          } else {
            context.read<TutorProvider>().clearSpec(widget.index);
          }
        }
      },
      selected: isSelected,
    );
  }
}

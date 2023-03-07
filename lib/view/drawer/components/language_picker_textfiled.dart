import 'package:flutter/material.dart';

class LanguageFormField extends StatefulWidget {
  final List<String> languages;
  final IconData icon;
  final String label;

  LanguageFormField({required this.languages, required this.icon, required this.label});
  @override
  _LanguageFormFieldState createState() => _LanguageFormFieldState();
}

class _LanguageFormFieldState extends State<LanguageFormField> {
  List<String> _selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(widget.icon),
          onPressed: () => _showLanguagePicker(context),
        ),
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      readOnly: true,
      onTap: () => _showLanguagePicker(context),
      controller: TextEditingController(
          text: _selectedLanguages.isNotEmpty
              ? _selectedLanguages.join(', ')
              : null),
    );
  }

  void _showLanguagePicker(BuildContext context) async {
    List<PopupMenuEntry<String>> _popupMenuItems = widget.languages
        .map(
          (language) => PopupMenuItem<String>(
            value: language,
            child: ListTile(
              title: Text(language),
              trailing: _selectedLanguages.contains(language)
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
          ),
        )
        .toList();

    String? selectedLanguage = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: _popupMenuItems,
      elevation: 8.0,
    );

    if (selectedLanguage != null) {
      setState(() {
        if (_selectedLanguages.contains(selectedLanguage)) {
          _selectedLanguages.remove(selectedLanguage);
        } else {
          _selectedLanguages.add(selectedLanguage);
        }
      });
    }
  }
}

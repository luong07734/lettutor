import 'package:flutter/material.dart';
import 'package:lettutor/ultilities/theme.dart';
import 'package:provider/provider.dart';

class SettingThemeDropdownButton extends StatefulWidget {
  const SettingThemeDropdownButton({Key? key}) : super(key: key);

  @override
  _SettingThemeDropdownButtonState createState() =>
      _SettingThemeDropdownButtonState();
}

class _SettingThemeDropdownButtonState
    extends State<SettingThemeDropdownButton> {
  String _selectedTheme = "Light";

  @override
  Widget build(BuildContext context) {
    final ThemeProfile themeProfile = Provider.of<ThemeProfile>(context);

    return DropdownButton(
      icon: Container(),
      underline: Container(),
      value: _selectedTheme,
      onChanged: (value) {
        setState(() {
          _selectedTheme = value as String;

          if (value == "Light") {
            themeProfile.setLightTheme();
          } else if (value == "Dark") {
            themeProfile.setDarkTheme();
          }
          print(_selectedTheme);
        });
      },
      items: ["Light", "Dark"].map<DropdownMenuItem<String>>((String value) {
        bool _isLight = value == "Light";
        IconData _icon = _isLight ? Icons.wb_sunny_rounded : Icons.brightness_2;
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Icon(
                _icon,
                color: _isLight ? Colors.yellow : Colors.white,
                size: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

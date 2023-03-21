import 'package:flutter/material.dart';
import 'package:lettutor/view/screens/settings/components/language_dropdown_button.dart';
import 'package:lettutor/view/screens/settings/components/settings_button.dart';

List<Map<String, dynamic>> _languageOptions = [
  {
    'value': 'en',
    'label': 'English',
    'flag': 'assets/images/flags/united-kingdom.svg',
  },
  {
    'value': 'vi',
    'label': 'Tiếng Việt',
    'flag': 'assets/images/flags/vietnam.svg',
  },
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Column(
          children: [
            SettingsButton(
                onPress: () {
                  print("press");
                },
                icon: const Icon(
                  Icons.language_rounded,
                ),
                title: "settings",
                child: const SettingLanguageDropdownButton()),
            // SettingsButton(
            //     onPress: null,
            //     icon: const Icon(
            //       Icons.light_sharp,

            //     ),
            //     title: "settings",
            //     child: const SettingThemeDropdownButton()),
          ],
        ));
  }
}

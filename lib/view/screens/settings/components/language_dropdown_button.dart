import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/data/provider/language.dart';
import 'package:provider/provider.dart';

class SettingLanguageDropdownButton extends StatefulWidget {
  const SettingLanguageDropdownButton({
    Key? key,
  }) : super(key: key);

  @override
  _SettingLanguageDropdownButtonState createState() =>
      _SettingLanguageDropdownButtonState();
}

class _SettingLanguageDropdownButtonState
    extends State<SettingLanguageDropdownButton> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final LanguageProfile languageProfile =
        Provider.of<LanguageProfile>(context);

    if (languageProfile.languageCode == LanguageProfile.codeEN) {
      _selectedLanguage = 'English';
    } else {
      _selectedLanguage = "Tiếng Việt";
    }
    return DropdownButton(
      alignment: Alignment.centerRight,
      icon: Container(),
      value: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value as String;
          if (value == 'English') {
            languageProfile.changeLanguage(LanguageProfile.codeEN);
          } else if (value == "Tiếng Việt") {
            languageProfile.changeLanguage(LanguageProfile.codeVN);
          }
        });
      },
      // onChanged: null,
      underline: Container(),
      items: ["English", "Tiếng Việt"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              // SvgPicture.asset(
              //   value == "English"
              //       ? Assets.assetsIconsUk
              //       : Assets.assetsIconsVn,
              //   width: 17,
              // ),
              Image.asset(
                value == "English"
                    ? AssetsManager.ukFlagImage
                    : AssetsManager.vnFlagImage,
                width: 16,
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

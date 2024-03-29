import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/is_auto_tts.dart';
import 'package:lettutor/data/provider/speech_language.dart';
import 'package:lettutor/data/shared_preference/constants/shared_preference_keys.dart';
import 'package:lettutor/view/screens/chat/components/custom_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isToggleOn = true;
  String _selectedLanguage = 'English';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _deleteData() async {
    await _prefs.remove(SharedPreferenceKeys.messages);
    print('delete messages');
    // Refresh UI if necessary
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SpeechLanguageProfile speechLanguageProfile =
        Provider.of<SpeechLanguageProfile>(context);
    final AutoTTSProfile autoTTSProfile = Provider.of<AutoTTSProfile>(context);

    if (speechLanguageProfile.speechLanguageCode ==
        SpeechLanguageProfile.enSpeechLanguageCode) {
      _selectedLanguage = 'English';
    } else {
      _selectedLanguage = "Vietnamese";
    }
    _isToggleOn = autoTTSProfile.autoTTS;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(AppLocalizations.of(context)!.chatSettings),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_circle),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.autoTTS,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  CustomSwitch(
                    initialValue: autoTTSProfile.autoTTS,
                    onChanged: (value) {
                      // Do something when the switch is tapped

                      setState(() {
                        autoTTSProfile.changeAutoTTS(value);
                        _isToggleOn = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language_rounded,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.speechLanguage,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue == 'English') {
                          speechLanguageProfile.changeLanguage(
                              SpeechLanguageProfile.enSpeechLanguageCode);
                          _selectedLanguage = 'English';
                        } else if (newValue == "Vietnamese") {
                          speechLanguageProfile.changeLanguage(
                              SpeechLanguageProfile.viSpeechLanguageCode);
                          _selectedLanguage = 'Vietnamese';
                        }
                      });
                    },
                    items: <String>['English', 'Vietnamese']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _deleteData();
                  // ChatPage.of(context)?.deleteMessages();
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 10,
                ),
                child: Text(
                  AppLocalizations.of(context)!.deleteAllMessages,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

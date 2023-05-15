import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/test_preperations.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/view/widgets/view_items/textfields/country_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/date_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/form_textfield.dart';
import 'package:provider/provider.dart';
import 'package:lettutor/constants/level_options.dart';
import 'package:multiselect/multiselect.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  // final TextEditingController _myLevelController = TextEditingController();
  // final TextEditingController _testPracticeController = TextEditingController();
  String _selectedOption = "BEGINNER";
  List<LearnTopic?> initTopics = [];

  List<LearnTopic?> _selectedTopics = [];

  // final _testPrepsItems = testPreperations
  //     .map((testPrep) => MultiSelectItem<LearnTopic?>(testPrep!, testPrep.name))
  //     .toList();
  File? _imageFile;

  final _testPreps = testPreperations.map((e) => e!.name).toList();
  List<String> _selectedTestPreps = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    AuthenticationProvider profile =
        Provider.of<AuthenticationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  _loadUser() async {
    AuthenticationProvider profile =
        Provider.of<AuthenticationProvider>(context, listen: false);
    profile.loadUser1().then((value) {
      setState(() {
        _fullNameController.text = profile.currentLoggedUser!.name!;
        _phoneNumberController.text = profile.currentLoggedUser!.phone!;
        _birthdayController.text = profile.currentLoggedUser!.birthday == null
            ? ""
            : profile.currentLoggedUser!.birthday!.toString();
        _countryController.text = profile.currentLoggedUser!.country == null
            ? ""
            : profile.currentLoggedUser!.country!;
        // _myLevelController.text = profile.currentLoggedUser!.level == null
        //     ? ""
        //     : profile.currentLoggedUser!.level;
        _selectedOption = profile.currentLoggedUser!.level == null
            ? "BEGINNER"
            : profile.currentLoggedUser!.level;
        // _testPracticeController.text = 'IELTS';
        _selectedTopics = profile.currentLoggedUser!.testPreparations == null
            ? []
            : profile.currentLoggedUser!.testPreparations!;
        _selectedTestPreps = profile.currentLoggedUser!.testPreparations == null
            ? []
            : profile.currentLoggedUser!.testPreparations!
                .map((e) => e.name)
                .toList();
        // initTopics = _selectedTopics;
      });
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = File(image!.path);
      AuthenticationProvider profile =
          Provider.of<AuthenticationProvider>(context, listen: false);
      profile.avatarImage = File(image.path);
    });
  }

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider profile =
        Provider.of<AuthenticationProvider>(context, listen: false);

    // initTopics = _selectedTopics;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.profile),
          centerTitle: true,
          elevation: 3,
        ),
        body: SingleChildScrollView(
          child:
              Consumer<AuthenticationProvider>(builder: (context, profile, _) {
            // print(profile.currentLoggedUser!.testPreparations!);
            // print(_selectedTopics);

            return Form(
              key: _formKey,
              child: Container(
                // color: Colors.grey[200], // set background color here
                padding: EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 3,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => _pickImage(ImageSource.gallery),
                          child: Stack(children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : profile.currentLoggedUser!.avatar ==
                                                  null ||
                                              profile.currentLoggedUser!.avatar!
                                                  .contains(
                                                      "icon-avatar-default.png")
                                          ? AssetImage(
                                              AssetsManager.userAvatarImage)
                                          : NetworkImage(
                                              profile
                                                  .currentLoggedUser!.avatar!,
                                            ) as ImageProvider<Object>,
                                ),
                                border: Border.all(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  width: 4,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Handle edit avatar click
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FormTextField(
                        title: AppLocalizations.of(context)!.name,
                        icon: Icons.person,
                        controller: _fullNameController,
                        hint: AppLocalizations.of(context)!.enterName,
                        enabled: true,
                      ),
                      const SizedBox(height: 16),
                      FormTextField(
                        title: AppLocalizations.of(context)!.phoneNumber,
                        icon: Icons.phone,
                        controller: _phoneNumberController,
                        hint: "Enter your Phone Number",
                        enabled: false,
                      ),
                      const SizedBox(height: 16),
                      DatePickerFormField(
                        title: AppLocalizations.of(context)!.birthday,
                        controller: _birthdayController,
                        hint: AppLocalizations.of(context)!.enterDob,
                      ),
                      const SizedBox(height: 16),
                      FlagTextFormField(
                        title: AppLocalizations.of(context)!.country,
                        controller: _countryController,
                        hint: AppLocalizations.of(context)!.enterCountry,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterLevel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // suffixIcon: Icon(Icons.upgrade),
                          labelText: AppLocalizations.of(context)!.myLevel,
                          // floatingLabelBehavior: Floating LabelBehavior.always,
                        ),
                        value: _selectedOption,
                        items: levelOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                            print("setstate ${_selectedOption}");
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropDownMultiSelect(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // suffixIcon: Icon(Icons.upgrade),
                          labelText:
                              AppLocalizations.of(context)!.testPreparation,
                          // floatingLabelBehavior: Floating LabelBehavior.always,
                        ),
                        onChanged: (List<String> x) {
                          setState(() {
                            _selectedTestPreps = x;
                          });
                        },
                        options: _testPreps,
                        selectedValues: _selectedTestPreps,
                        // whenEmpty: 'Select test preperation',
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // save to tempCurrentUser
                            profile.tempCurrentUser!.name =
                                _fullNameController.text.toString();
                            profile.tempCurrentUser!.phone =
                                _phoneNumberController.text.toString();
                            profile.tempCurrentUser!.birthday =
                                _birthdayController.text.toString();
                            profile.tempCurrentUser!.country =
                                _countryController.text.toString();
                            print("press to string $_selectedOption");
                            profile.tempCurrentUser!.level =
                                _selectedOption.toString();

                            print(profile.tempCurrentUser!.testPreparations);
                            // profile.tempCurrentUser!.testPreparations =
                            //     _selectedTopics.cast<LearnTopic>();
                            profile.tempCurrentUser!.testPreparations =
                                _selectedTestPreps
                                    .map((name) => testPreperations.firstWhere(
                                        (learnTopic) =>
                                            learnTopic!.name == name))
                                    .cast<LearnTopic>()
                                    .toList();

                            profile.updateProfile(context);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.saveChanges),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}

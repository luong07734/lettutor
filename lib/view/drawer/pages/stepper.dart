import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/authentication/components/custom_textfield.dart';
import 'package:lettutor/view/detail/components/profile_description.dart';
import 'package:lettutor/view/detail/components/profile_title.dart';
import 'package:lettutor/view/drawer/components/country_picker_textfield.dart';
import 'package:lettutor/view/drawer/components/custom_textfield.dart';
import 'package:lettutor/view/drawer/components/date_picker_textfield.dart';
import 'package:lettutor/view/drawer/components/language_picker_textfiled.dart';
import 'package:lettutor/view/drawer/components/paragraph_textfield.dart';

class RegisterStepper extends StatefulWidget {
  @override
  _RegisterStepperState createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  int currentStep = 0;
  int _selectedOption = 1; // initial selected option value
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _doBController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  File? _imageFile;
  List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic'
  ];

  List<String> _specialities = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic'
  ];
  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _doBController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: 0,
      onStepContinue: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            currentStep++;
          });
        }
      },
      onStepCancel: () {
        setState(() {
          currentStep--;
        });
      },
      steps: [
        Step(
          title: Text(
            'Complete profile',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          isActive: true,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTitle(text: "Set up your tutor profile"),
              ProfileDescription(
                  text:
                      "You tutor profile is your chance to market yourself to students on Lettutor. You can make edits later on your profile settings page.\n\nNew students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already."),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              ProfileTitle(text: "Basic Info"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Please upload your professional photo.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: ColorsManager.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _imageFile == null
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                          ),
                          iconSize: 160,
                          // color: Colors.grey[100],
                          onPressed: () => _pickImage(ImageSource.gallery),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => _pickImage(ImageSource.gallery),
                      child: Image.file(_imageFile!),
                    ),
              SizedBox(height: 16),
              FormTextField(
                  title: "Full name",
                  icon: Icons.person,
                  controller: _fullnameController,
                  hint: "Enter your full name"),
              SizedBox(height: 16),
              DatePickerFormField(
                title: 'Date of Birth',
                controller: _doBController,
                hint: "Select your birthday",
              ),
              SizedBox(height: 16),
              FlagTextFormField(
                title: "Country",
                controller: _countryController,
                hint: "Select your country",
              ),
              ProfileTitle(text: "CV"),
              ParagraphTextField(
                  title: "Interests",
                  controller: _interestController,
                  hint: "Interests, hobbies, ..."),
              SizedBox(height: 16),
              ParagraphTextField(
                  title: "Education",
                  controller: _educationController,
                  hint: "Enter your Education"),
              SizedBox(height: 16),
              ParagraphTextField(
                  title: "Experience",
                  controller: _experienceController,
                  hint: "Enter your Experience"),
              SizedBox(height: 16),
              ParagraphTextField(
                  title: "Professsion",
                  controller: _professionController,
                  hint: "Current or Previous"),
              SizedBox(height: 8),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              ProfileTitle(text: "Language I speak"),
              LanguageFormField(
                languages: _languages,
                icon: Icons.language,
              ),
              SizedBox(height: 8),
              Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
              ProfileTitle(text: "Who I teach"),
              ParagraphTextField(
                  title: "Introduction",
                  controller: _introductionController,
                  hint: "Example: I was a teacher ..."),
              ProfileTitle(text: "My specialities are"),
              LanguageFormField(languages: _specialities, icon: Icons.bookmark),
              ProfileTitle(text: "I am best at teaching students who are"),
              Column(
                children: [
                  RadioListTile(
                    title: Text('Beginner'),
                    value: 1,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Intermediate'),
                    value: 2,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Advanced'),
                    value: 3,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

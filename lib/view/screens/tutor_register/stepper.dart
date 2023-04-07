import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:lettutor/view/widgets/view_items/textfields/country_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/form_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/date_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/language_picker_textfiled.dart';
import 'package:lettutor/view/widgets/view_items/textfields/paragraph_textfield.dart';
import 'package:video_player/video_player.dart';

class RegisterStepper extends StatefulWidget {
  static String routeName = "/become_teacher";
  @override
  _RegisterStepperState createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  int _currentStep = 0;
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

  // handle video picker
  VideoPlayerController? _videoPlayerController;
  File? _video;

  final picker = ImagePicker();

  _pickVideo() async {
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);

    _video = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Become a Tutor')),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (index) {
          setState(() {
            _currentStep = index;
          });
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep < 2) {
              _currentStep++;
            } else {
              // perform any action on last step continue button press
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            } else {
              // perform any action on first step cancel button press
            }
          });
        },
        steps: [
          Step(
            title: const Text(
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
                const ProfileTitle(text: "Set up your tutor profile"),
                const ProfileDescription(
                    text:
                        "You tutor profile is your chance to market yourself to students on Lettutor. You can make edits later on your profile settings page.\n\nNew students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already."),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const ProfileTitle(text: "Basic Info"),
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
                const SizedBox(
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
                            icon: const Icon(
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
                const SizedBox(height: 16),
                FormTextField(
                  title: "Full name",
                  icon: Icons.person,
                  controller: _fullnameController,
                  hint: "Enter your full name",
                  enabled: true,
                ),
                const SizedBox(height: 16),
                DatePickerFormField(
                  title: 'Date of Birth',
                  controller: _doBController,
                  hint: "Select your birthday",
                ),
                const SizedBox(height: 16),
                FlagTextFormField(
                  title: "Country",
                  controller: _countryController,
                  hint: "Select your country",
                ),
                const ProfileTitle(text: "CV"),
                ParagraphTextField(
                    title: "Interests",
                    controller: _interestController,
                    hint: "Interests, hobbies, ..."),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: "Education",
                    controller: _educationController,
                    hint: "Enter your Education"),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: "Experience",
                    controller: _experienceController,
                    hint: "Enter your Experience"),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: "Professsion",
                    controller: _professionController,
                    hint: "Current or Previous"),
                const SizedBox(height: 8),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const ProfileTitle(text: "Language I speak"),
                LanguageFormField(
                  languages: _languages,
                  icon: Icons.language,
                  label: "Language",
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const ProfileTitle(text: "Who I teach"),
                ParagraphTextField(
                    title: "Introduction",
                    controller: _introductionController,
                    hint: "Example: I was a teacher ..."),
                const ProfileTitle(text: "My specialities are"),
                LanguageFormField(
                  languages: _specialities,
                  icon: Icons.bookmark,
                  label: "Specialities",
                ),
                const ProfileTitle(
                    text: "I am best at teaching students who are"),
                Column(
                  children: [
                    RadioListTile(
                      title: const Text('Beginner'),
                      value: 1,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Intermediate'),
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Advanced'),
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
          Step(
            isActive: true,
            title: const Text(
              'Video Introduction',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileTitle(text: "Introduce yourself"),
                const ProfileDescription(
                    text:
                        "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you."),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const ProfileTitle(text: "Introduction video"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'A few useful tips:\n1. Find a clean and quiet space\n2.Smile and look at the camera\n3. Dress smart\n4. Speak for 1-3 minutes\n5. Brand yourself and have fun',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (_video != null)
                  _videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                      : Container()
                else
                  const Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: const Text("Pick Video From Gallery"),
                ),
              ],
            ),
          ),
          Step(
            title: const Text(
              'Approval',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            isActive: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.doneImage,
                ),
                const Text(
                  "You have done all the steps\n Pleasse, wait for the operator's approval",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/data/network/apis/become-tutor/become_tutor_api.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:lettutor/view/widgets/view_items/textfields/country_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/form_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/date_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/language_picker_textfiled.dart';
import 'package:lettutor/view/widgets/view_items/textfields/paragraph_textfield.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RegisterStepper extends StatefulWidget {
  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
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
  String _selectedLanguages = "";
  String _selectedSpec = "";
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
    'English for Kids',
    'Business English',
    'Conversational English',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    "IELTS",
    "TOEFL",
    "TOEFL",
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
  Map<String, String> body = {};

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
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.becomeATutor),
        centerTitle: true,
        elevation: 3,
      ),
      body: Stepper(
        controlsBuilder: (context, controller) {
          return const SizedBox.shrink();
        },
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
            title: Text(
              AppLocalizations.of(context)!.completeProfile,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            isActive: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileTitle(text: AppLocalizations.of(context)!.setUpProfile),
                ProfileDescription(
                    text: AppLocalizations.of(context)!.step1Description),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                ProfileTitle(text: AppLocalizations.of(context)!.basicInfo),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.pleaseUploadPhoto,
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
                  title: AppLocalizations.of(context)!.tutoringName,
                  icon: Icons.person,
                  controller: _fullnameController,
                  hint:  AppLocalizations.of(context)!.enterName,
                  enabled: true,
                ),
                const SizedBox(height: 16),
                DatePickerFormField(
                  title: AppLocalizations.of(context)!.dob,
                  controller: _doBController,
                  hint:  AppLocalizations.of(context)!.enterDob,
                ),
                const SizedBox(height: 16),
                FlagTextFormField(
                  title: AppLocalizations.of(context)!.imFrom,
                  controller: _countryController,
                  hint:  AppLocalizations.of(context)!.enterCountry,
                ),
                const ProfileTitle(text: "CV"),
                ParagraphTextField(
                    title: AppLocalizations.of(context)!.interest,
                    controller: _interestController,
                    hint:  AppLocalizations.of(context)!.enterInterest),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: AppLocalizations.of(context)!.educationTutor,
                    controller: _educationController,
                    hint:  AppLocalizations.of(context)!.enterEducation),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: AppLocalizations.of(context)!.experienceTutor,
                    controller: _experienceController,
                    hint:  AppLocalizations.of(context)!.enterExperience),
                const SizedBox(height: 16),
                ParagraphTextField(
                    title: AppLocalizations.of(context)!.professionTutor,
                    controller: _professionController,
                    hint:  AppLocalizations.of(context)!.enterExperience),
                const SizedBox(height: 8),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                ProfileTitle(
                    text: AppLocalizations.of(context)!.languageISpeak),
                LanguageFormField(
                  languages: _languages,
                  icon: Icons.language,
                  label: AppLocalizations.of(context)!.languages,
                  onSelectedLanguagesChanged: (languages) {
                    setState(() {
                      _selectedLanguages =
                          languages.isNotEmpty ? languages.join(', ') : "";
                    });
                  },
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                ProfileTitle(text: AppLocalizations.of(context)!.whoITeach),
                ParagraphTextField(
                    title: AppLocalizations.of(context)!.introduction,
                    controller: _introductionController,
                    hint:  AppLocalizations.of(context)!.enterIntroduction),
                ProfileTitle(text: AppLocalizations.of(context)!.mySpecialties),
                LanguageFormField(
                  languages: _specialities,
                  icon: Icons.bookmark,
                  label:  AppLocalizations.of(context)!.specialities,
                  onSelectedLanguagesChanged: (specs) {
                    setState(() {
                      _selectedLanguages =
                          specs.isNotEmpty ? specs.join(', ') : "";
                    });
                  },
                ),
                ProfileTitle(text: AppLocalizations.of(context)!.iAmBest),
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
            title: Text(
              AppLocalizations.of(context)!.introductionVideo,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileTitle(
                    text: AppLocalizations.of(context)!.introduceYourself),
                ProfileDescription(
                    text: AppLocalizations.of(context)!.letStudentKnow),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                ProfileTitle(
                    text: AppLocalizations.of(context)!.introductionVideo),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context)!.usefulTips,
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
                  Text(
                    AppLocalizations.of(context)!.clickOnPickVideo,
                    style: TextStyle(fontSize: 18.0),
                  ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text(AppLocalizations.of(context)!.chooseVideo),
                ),
              ],
            ),
          ),
          Step(
            title: Text(
              AppLocalizations.of(context)!.approval,
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
                Text(
                  AppLocalizations.of(context)!.submitForm,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      body["name"] = _fullnameController.text;
                      body["country"] = _countryController.text;
                      body["birthday"] = _doBController.text;
                      body["interests"] = _interestController.text;
                      body["education"] = _educationController.text;
                      body["experience"] = _experienceController.text;
                      body["profession"] = _professionController.text;
                      body["languages"] = _selectedLanguages;
                      body["bio"] = _introductionController.text;
                      body["targetStudent"] = _currentStep == 1
                          ? "Beginner"
                          : (_currentStep == 2 ? "Intermediate" : "Advance");
                      body["specialities"] = _selectedSpec;
                      body["price"] = 50000.toString();
                      // body["avatar"] = _imageFile;
                      // body["video"] = _video;
                    });
                    final BecomeTutorApi _api = BecomeTutorApi();
                    if (_video != null && _imageFile != null) {
                      _api
                          .becomeTutor(body, _video!, _imageFile!)
                          .then((value) {
                        if (value) {
                          Fluttertoast.showToast(
                              msg: "Your information has been sent",
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 2);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Send failed",
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 2);
                        }
                      });
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.submit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

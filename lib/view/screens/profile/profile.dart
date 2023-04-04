import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/view/widgets/view_items/textfields/country_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/date_picker_textfield.dart';
import 'package:lettutor/view/widgets/view_items/textfields/form_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _myLevelController = TextEditingController();
  final TextEditingController _testPracticeController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // TODO: load profile data from somewhere, such as shared preferences or a database
    _fullNameController.text = 'John Doe';
    _phoneNumberController.text = '555-555-1234';
    _birthdayController.text = '01/01/2000';
    _countryController.text = 'United States';
    _myLevelController.text = 'Beginner';
    _testPracticeController.text = 'IELTS';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200], // set background color here
          padding: EdgeInsets.all(16.0),
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                // CircleAvatar(
                //   radius: 64,
                //   backgroundImage:
                //       NetworkImage('https://picsum.photos/id/237/200/200'),
                // ),
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
                    controller: _fullNameController,
                    hint: "Enter your full name"),
                const SizedBox(height: 16),
                FormTextField(
                    title: "Phone Number",
                    icon: Icons.phone,
                    controller: _phoneNumberController,
                    hint: "Enter your Phone Number"),
                const SizedBox(height: 16),
                DatePickerFormField(
                  title: 'Date of Birth',
                  controller: _birthdayController,
                  hint: "Select your birthday",
                ),
                const SizedBox(height: 16),
                FlagTextFormField(
                  title: "Country",
                  controller: _countryController,
                  hint: "Select your country",
                ),
                const SizedBox(height: 16),
                FormTextField(
                    title: "Level",
                    icon: Icons.numbers,
                    controller: _myLevelController,
                    hint: "Enter your level"),
                const SizedBox(height: 16),
                FormTextField(
                    title: "Test Practise",
                    icon: Icons.book,
                    controller: _testPracticeController,
                    hint: "Enter your Test Practise"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

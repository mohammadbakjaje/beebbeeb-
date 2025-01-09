import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/my_colors.dart';
import '../../../widget/coustembutonm.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? _imageFile;
  bool _isEditing = false;

  final TextEditingController _firstNameController =
      TextEditingController(text: "Malak");
  final TextEditingController _lastNameController =
      TextEditingController(text: "Mobark");
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "0995658340");
  final TextEditingController _locationController =
      TextEditingController(text: "Damascus");
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
  void _showImageSourceOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors.dark_2,
          title: Text(
            'Choose Image Source',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                title: Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                title: Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors.dark_2,
          title: Text(
            'Change Password',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.buttun),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.buttun),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
              TextField(
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyColors.buttun),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: MyColors.buttun)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save', style: TextStyle(color: MyColors.buttun)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.dark_1,
        actions: <Widget>[
          IconButton(
            icon: Icon(_isEditing ? Icons.edit : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _isEditing
                    ? () {
                        _showImageSourceOptions();
                      }
                    : null,
                child: _imageFile != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(_imageFile!.path)),
                      )
                    : CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 50),
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEditing ? MyColors.buttun : Colors.grey,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: _isEditing ? Colors.white : Colors.white70,
                  fontSize: 18,
                ),
                readOnly: !_isEditing,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEditing ? MyColors.buttun : Colors.grey,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: _isEditing ? Colors.white : Colors.white70,
                  fontSize: 18,
                ),
                readOnly: !_isEditing,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEditing ? MyColors.buttun : Colors.grey,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: _isEditing ? Colors.white : Colors.white70,
                  fontSize: 18,
                ),
                readOnly: !_isEditing,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEditing ? MyColors.buttun : Colors.grey,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: _isEditing ? Colors.white : Colors.white70,
                  fontSize: 18,
                ),
                readOnly: !_isEditing,
              ),
              SizedBox(height: 20),
              if (_isEditing)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80),
                      child: CoustemButonM(
                        text: "Change Password",
                        color: MyColors.buttun,
                        ontap: () {
                          _showChangePasswordDialog();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80),
                      child: CoustemButonM(
                        text: "Save",
                        color: MyColors.buttun,
                        ontap: () {
                          setState(() {
                            _isEditing = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

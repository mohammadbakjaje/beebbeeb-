import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/Screens/HomePage/HomePage.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/change_password_state.dart';
import 'package:untitled1/Screens/Layout/Profile/update_image_cubit/update_Image_states.dart';
import 'package:untitled1/Screens/Layout/Profile/update_image_cubit/update_image_cubit.dart';
import 'package:untitled1/Screens/Layout/Profile/update_user_cubit/update_user_cubit.dart';
import 'package:untitled1/Screens/Layout/Profile/update_user_cubit/update_user_states.dart';

import '../../../helper/constants.dart';
import '../../../helper/local_network.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/coustembutonm.dart';
import '../Layout_cubit/change_password_cubit.dart';
import '../Layout_cubit/layout_cubit.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? _imageFile;
  bool _isEditing = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LayoutCubit>(context).getUserData();
  }

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
        return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) {
            return AlertDialog(
              backgroundColor: MyColors.dark_2,
              title: Text(
                'Change Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _currentPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 13),
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
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 13),
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
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 13),
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
                Row(
                  children: [
                    if (state is ChangePasswordLoading)
                      CircularProgressIndicator()
                    else
                      TextButton(
                        child: Text('Save',
                            style: TextStyle(color: MyColors.buttun)),
                        onPressed: () {
                          context.read<ChangePasswordCubit>().changePassword(
                              currentPassword: _currentPasswordController.text,
                              newPassword: _newPasswordController.text,
                              confirmPassword:
                                  _confirmNewPasswordController.text,
                              token: CacheNetwork.getCacheData(key: "token"));
                        },
                      ),
                    TextButton(
                      child: Text('Cancel',
                          style: TextStyle(color: MyColors.buttun)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
          listener: (BuildContext context, ChangePasswordState state) {
            if (state is ChangePasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              _currentPasswordController.clear();
              _newPasswordController.clear();
              _confirmNewPasswordController.clear();

              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  void _saveUserData() {
    context.read<UpdateUserCubit>().updateUser(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phone: _phoneNumberController.text,
        );

    if (_imageFile != null) {
      context.read<UploadImageCubit>().uploadImage(File(_imageFile!.path));
    }

    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    layoutCubit..getUserData();
    final userModel = layoutCubit.userModel;

    _firstNameController.text = userModel?.firstname ?? "";
    _lastNameController.text = userModel?.lastname ?? "";
    _phoneNumberController.text = userModel?.phone ?? "";
    _locationController.text = "Damascus";

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpdateUserCubit()),
        BlocProvider(create: (context) => UploadImageCubit()),
      ],
      child: Scaffold(
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
        body: BlocListener<UploadImageCubit, UploadImageState>(
          listener: (context, state) {
            if (state is UploadImageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is UploadImageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
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
                            backgroundImage: _imageFile != null
                                ? FileImage(File(_imageFile!.path))
                                : (userModel?.image != null
                                    ? NetworkImage(
                                        "http://$ipv4${userModel!.image!}")
                                    : null),
                            child: _imageFile == null &&
                                        (userModel?.image == null) ||
                                    (userModel?.image == "")
                                ? Icon(Icons.person, size: 50)
                                : null,
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    controller: _locationController,
                    labelText: 'Location',
                    icon: Icons.location_on,
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
                              _saveUserData();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  BlocListener<UpdateUserCubit, UpdateUserState>(
                    listener: (context, state) {
                      if (state is UpdateUserSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is UpdateUserFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.buttun),
        ),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      style: TextStyle(
        color: _isEditing ? Colors.white : Colors.white70,
        fontSize: 18,
      ),
      readOnly: !_isEditing,
    );
  }
}

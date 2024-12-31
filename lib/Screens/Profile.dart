import 'package:flutter/material.dart';

import '../helper/my_colors.dart';
import '../widget/coustembutonm.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: null,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: CoustemButonM(
                  text: "Save",
                  color: MyColors.buttun,
                  ontap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

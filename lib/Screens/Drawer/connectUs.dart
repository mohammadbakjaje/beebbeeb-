import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/my_colors.dart';

class ConnectUs extends StatelessWidget {
  static String id = "ConnectUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect Us',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
        ),
        foregroundColor: Colors.white,
        backgroundColor: MyColors.dark_2,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: MyColors.dark_1,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Front End Developer",style: TextStyle(color: Colors.white,fontSize: 20),),
            SizedBox(
              width: 200,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
              ),),
            Text("Malak Mobark",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('0995658340');
              },
            ),
            SizedBox(height: 10),
            Text("Malak Mobark",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('+1234567890');
              },
            ),
            SizedBox(height: 10),
            Text("Malak Mobark",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('+1234567890');
              },
            ),
            SizedBox(height: 10),
            Text("Back End Developer",style: TextStyle(color: Colors.white,fontSize: 20),),
            SizedBox(
              width: 190,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
              ),),
            Text("Malak Mobark",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('+1234567890');
              },
            ),
            SizedBox(height: 10),
            Text("Malak Mobark",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('+1234567890');
              },
            ),
            SizedBox(height: 20),

            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _launchPhone(String phone) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunch(params.toString())) {
      await launch(params.toString());
    } else {
      throw 'Could not launch phone';
    }
  }
}
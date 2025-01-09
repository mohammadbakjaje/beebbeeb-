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
            Text("Mohammad Bakjaje",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: mbakjaje@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0943704418',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('0943704418');
              },
            ),
            SizedBox(height: 10),
            Text("Hala Barhoom",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: halabarhoom@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0998687702',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('0998687702');
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
            Text("Hadi Al_Gafer",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: algaferm@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0938523272',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('0938523272');
              },
            ),
            SizedBox(height: 10),
            Text("Nour Naief Al_Haies",style: TextStyle(color: MyColors.buttun,fontSize: 18),),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: naiefnoura@gmail.com',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: 0955422200',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                _launchPhone('0955422200');
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
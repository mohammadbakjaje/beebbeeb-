import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import ' theme_provider.dart';
import '../../helper/my_colors.dart';


class ConnectUs extends StatelessWidget {
  static String id = "ConnectUs";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect Us',
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : MyColors.buttun,
        iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white : Colors.white),
      ),
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Front End Developer",
              style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              width: 200,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
              ),
            ),
            Text(
              "Malak Mobark",
              style: TextStyle(color: MyColors.buttun, fontSize: 18),
            ),
            ListTile(
              leading: Icon(Icons.email,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Email: malakmobark4@gmail.com',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Phone: 0995658340',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
              onTap: () {
                _launchPhone('0995658340');
              },
            ),
            SizedBox(height: 10),
            Text(
              "Mohammad Bakjaje",
              style: TextStyle(color: MyColors.buttun, fontSize: 18),
            ),
            ListTile(
              leading: Icon(Icons.email,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Email: mbakjaje@gmail.com',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Phone: 0943704418',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
              onTap: () {
                _launchPhone('0943704418');
              },
            ),
            SizedBox(height: 10),
            Text(
              "Hala Barhoom",
              style: TextStyle(color: MyColors.buttun, fontSize: 18),
            ),
            ListTile(
              leading: Icon(Icons.email,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Email: halabarhoom@gmail.com',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Phone: 0998687702',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
              onTap: () {
                _launchPhone('0998687702');
              },
            ),
            SizedBox(height: 10),
            Text(
              "Back End Developer",
              style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20),
            ),
            SizedBox(
              width: 190,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
              ),
            ),
            Text(
              "Hadi Al_Gafer",
              style: TextStyle(color: MyColors.buttun, fontSize: 18),
            ),
            ListTile(
              leading: Icon(Icons.email,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Email: algaferm@gmail.com',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Phone: 0938523272',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
              onTap: () {
                _launchPhone('0938523272');
              },
            ),
            SizedBox(height: 10),
            Text(
              "Nour Naief Al_Haies",
              style: TextStyle(color: MyColors.buttun, fontSize: 18),
            ),
            ListTile(
              leading: Icon(Icons.email,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Email: naiefnoura@gmail.com',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: themeProvider.isDarkMode ? Colors.white : MyColors.buttun),
              title: Text(
                'Phone: 0955422200',
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
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
                  color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
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
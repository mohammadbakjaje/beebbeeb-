import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import ' theme_provider.dart';
import '../../helper/my_colors.dart';


class AboutUs extends StatelessWidget {
  static String id = "AboutUs";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : MyColors.buttun,
        iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white70 : Colors.white),
      ),
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My App',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to our app! 🌟\n\n'
                  'Our app is your ultimate destination for a seamless shopping experience. '
                  'With a wide range of stores and an extensive collection of products, '
                  'we bring everything you need right to your fingertips. '
                  'Whether you\'re looking for the latest fashion trends, electronics, home essentials, or groceries, '
                  'our app offers a diverse selection to cater to all your needs.\n\n'
                  'What sets us apart is our commitment to convenience and quality. '
                  'We partner with multiple stores to ensure you have access to the best products at competitive prices. '
                  'Our user-friendly interface makes browsing and shopping a breeze, '
                  'while our advanced search and filtering options help you find exactly what you\'re looking for in no time.\n\n'
                  'But that\'s not all! We understand the importance of timely delivery, '
                  'which is why we offer reliable delivery services to any area. '
                  'Whether you\'re at home, work, or on the go, '
                  'our efficient delivery system ensures your purchases reach you safely and on time.\n\n'
                  'Join thousands of satisfied customers who have made our app their go-to shopping platform. '
                  'Download now and experience the future of shopping! 🚀',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
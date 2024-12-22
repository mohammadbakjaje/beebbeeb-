import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Screens/login_page.dart';
import 'package:untitled1/Screens/register_page.dart';
import 'package:untitled1/Screens/reset_page.dart';
import 'package:untitled1/Screens/send_email_page.dart';

void main() {
  runApp(BebBeb());
}

class BebBeb extends StatelessWidget {
  const BebBeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage()
      },
      debugShowCheckedModeBanner: false,
      home: SendEmailPage(),
    );
  }
}

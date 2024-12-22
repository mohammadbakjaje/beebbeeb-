import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/coustem_buton.dart';

class SendEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/email send.png"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "We sent you an email to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CoustemButon(text: "Return to Login")
          ],
        ),
      ),
    );
  }
}

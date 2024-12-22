import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/coustem_buton.dart';
import 'package:untitled1/widget/coustem_text_filed.dart';

class ResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(backgroundColor: MyColors.dark_1),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Password",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 35),
              child: CoustemTextFormFiled(hintText: "Enter Email address"),
            ),
            CoustemButon(text: "Continue")
          ],
        ),
      ),
    );
  }
}

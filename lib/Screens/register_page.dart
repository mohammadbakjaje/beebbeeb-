import 'package:flutter/material.dart';

import '../helper/my_colors.dart';
import '../widget/coustem_buton.dart';
import '../widget/coustem_text_filed.dart';

class RegisterPage extends StatelessWidget {
  @override
  static String id = "RegisterPage";
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.dark_1,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: MyColors.dark_1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CoustemTextFormFiled(hintText: "Username"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CoustemTextFormFiled(hintText: "Email Address"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CoustemTextFormFiled(hintText: "Phone Number"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CoustemTextFormFiled(
                      hintText: "Password",
                      obsecure: true,
                    ),
                  ),
                  CoustemTextFormFiled(
                    hintText: "Confirm Password",
                    obsecure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: CoustemButon(text: "Continue"),
                  ),
                  Row(
                    children: [
                      Text(
                        "You have an account ? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

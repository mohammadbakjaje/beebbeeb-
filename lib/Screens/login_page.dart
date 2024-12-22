import 'package:flutter/material.dart';
import 'package:untitled1/Screens/register_page.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/coustem_buton.dart';
import 'package:untitled1/widget/coustem_text_filed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool obsecure = true;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.dark_1,
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(23),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                CoustemTextFormFiled(hintText: "Username or phone number"),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: obsecure,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "this field is required";
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              obsecure = !obsecure;
                              setState(() {});
                            },
                          )
                        ]),
                    fillColor: MyColors.dark_2,
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: MyColors.dark_2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.dark_2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Forget Password ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: GestureDetector(child: CoustemButon(text: "Continue")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(RegisterPage.id);
                      },
                      child: Text(
                        "Create One",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';

import '../helper/my_colors.dart';

class CoustemTextFormFiled extends StatelessWidget {
  String? hintText;
  Function(String)? onchanged;
  bool obsecure, password;

  CoustemTextFormFiled(
      {this.onchanged,
      required this.hintText,
      this.obsecure = false,
      this.password = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obsecure,
      validator: (data) {
        if (data!.isEmpty) {
          return "this field is required";
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        fillColor: MyColors.dark_2,
        filled: true,
        hintText: hintText,
        hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
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
    );
  }
}

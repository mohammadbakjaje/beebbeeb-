import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';

import '../helper/my_colors.dart';

class CoustemTextFormFiled extends StatelessWidget {
  String? hintText;
  Function(String)? onchanged;
  final String? Function(String?)? validator;
  bool obsecure, password;
  TextEditingController? controller;
  CoustemTextFormFiled(
      {this.onchanged,
      this.validator,
      required this.hintText,
      this.obsecure = false,
      this.password = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: obsecure,
      validator: validator,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.buttun),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.buttun),
          borderRadius: BorderRadius.circular(4),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

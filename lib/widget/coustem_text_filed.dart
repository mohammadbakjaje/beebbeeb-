import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/helper/my_colors.dart';


import '../Screens/Drawer/ theme_provider.dart'; // تأكد من استيراد ThemeProvider

class CoustemTextFormFiled extends StatelessWidget {
  final String? hintText;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final bool obsecure;
  final bool password;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  CoustemTextFormFiled({
    this.onchanged,
    this.validator,
    required this.hintText,
    this.obsecure = false,
    this.password = false,
    this.controller,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // تغيير لون النص
      obscureText: obsecure,
      validator: validator,
      onChanged: onchanged,
      decoration: InputDecoration(
        fillColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200], // تغيير لون الخلفية
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5), // تغيير لون النص
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!, // تغيير لون الحدود
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200]!), // تغيير لون الحدود
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
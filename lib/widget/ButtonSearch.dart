import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../Screens/Drawer/ theme_provider.dart';
import '../helper/my_colors.dart';


class ButtonSearch extends StatelessWidget {
  final String hintText;
  final Image prefixImage;
  final void Function(String) onchanged;

  ButtonSearch({
    required this.hintText,
    required this.prefixImage,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // الوصول إلى ThemeProvider

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        onChanged: onchanged,
        style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          prefixIcon: prefixImage,
          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10.0),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: themeProvider.isDarkMode ? Colors.white70 : Colors.white,
            fontWeight: FontWeight.bold,
          ),
          fillColor: themeProvider.isDarkMode ? MyColors.dark_2 : MyColors.buttun,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.buttun, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
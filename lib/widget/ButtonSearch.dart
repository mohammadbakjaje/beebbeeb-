import 'package:flutter/material.dart';

import '../helper/my_colors.dart';

class ButtonSearch extends StatelessWidget {
  final String hintText;
  final Image prefixImage;
  void Function(String) onchanged;
  ButtonSearch(
      {required this.hintText,
      required this.prefixImage,
      required this.onchanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        onChanged: onchanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: prefixImage,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18, color: Colors.white),
          fillColor: MyColors.dark_2,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          //border: InputBorder.none,
        ),
      ),
    );
  }
}

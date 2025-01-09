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
                const EdgeInsets.symmetric(vertical: 13, horizontal: 10.0),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w300),
            fillColor: MyColors.dark_2,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.buttun, width: 1),
              borderRadius: BorderRadius.circular(20),
            ) //border: InputBorder.none,
            ),
      ),
    );
  }
}

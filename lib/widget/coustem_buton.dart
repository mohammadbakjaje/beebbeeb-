import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';

class CoustemButon extends StatelessWidget {
  @override
  CoustemButon({this.ontap, required this.text});
  String text;
  VoidCallback? ontap;
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
                color: Colors.black,
              ),
              top: BorderSide(
                width: 1,
                color: Colors.black,
              ),
              bottom: BorderSide(
                width: 1,
                color: Colors.black,
              ),
              right: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ),
            color: MyColors.buttun,
            borderRadius: BorderRadius.circular(100),
          ),
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: MyColors.buttun),
            child: Center(
                child: Text(
              "$text",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )),
          ),
        ));
  }
}

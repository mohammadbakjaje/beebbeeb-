import 'package:flutter/material.dart';

class CoustemButonM extends StatelessWidget {
  @override
  CoustemButonM({this.ontap, required this.text, required this.color});

  String text;
  VoidCallback? ontap;
  Color color;

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
            borderRadius: BorderRadius.circular(100),
          ),
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: ontap,
            style: ElevatedButton.styleFrom(backgroundColor: color),
            child: Center(
                child: Text(
              "$text",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            )),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/helper/constants.dart';

import '../helper/my_colors.dart';

class ButtonOfStore extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  ButtonOfStore({
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.dark_2, width: 1),
            color: MyColors.dark_2, //
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  width: 80,
                  height: 80,
                  "http://$ipv4/${imagePath}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

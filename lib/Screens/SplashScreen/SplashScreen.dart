import 'package:flutter/material.dart';
import 'package:untitled1/helper/my_colors.dart';

import 'MovingImage.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
        ),
        backgroundColor: MyColors.dark_1,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 112,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 110,
                    backgroundImage: AssetImage(
                        "images/circular_beebbeeb-ai-brush-removebg-wym0tafo.png"),
                  ),
                ),
                Text(
                  "Beeb Beeb",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            MovingImage(),
          ],
        ));
  }
}

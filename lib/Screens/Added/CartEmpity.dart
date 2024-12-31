import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../helper/my_colors.dart';
import '../../widget/coustembutonm.dart';
import '../HomePage/HomePage.dart';

class CartEmpity extends StatefulWidget {
  @override
  State<CartEmpity> createState() => _CartEmpityState();
}

class _CartEmpityState extends State<CartEmpity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Container(
                child: Lottie.asset('images/Animation - 1735467766091.json'),
              ),
              Text(
                "The Cart is Empty !",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CoustemButonM(
            ontap: () {
              Navigator.of(context).pushNamed(HomePage.id);
              setState(() {});
            },
            text: "Order now !!",
            color: MyColors.buttun,
          ),
        ],
      ),
    );
  }
}

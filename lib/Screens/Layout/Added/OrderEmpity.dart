import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../helper/my_colors.dart';
import '../../../widget/coustembutonm.dart';
import '../../HomePage/HomePage.dart';

class OrderEmpity extends StatefulWidget {
  @override
  State<OrderEmpity> createState() => _OrderEmpityState();
}

class _OrderEmpityState extends State<OrderEmpity> {
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
                child:
                    Lottie.asset('images/Animation - 1735468941762 (1).json'),
              ),
              Text(
                "The Order is Empty !",
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

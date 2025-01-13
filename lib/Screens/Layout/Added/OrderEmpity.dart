import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../helper/my_colors.dart';
import '../../../widget/coustembutonm.dart';
import '../../Drawer/ theme_provider.dart';
import '../../HomePage/HomePage.dart';

class OrderEmpity extends StatefulWidget {
  @override
  State<OrderEmpity> createState() => _OrderEmpityState();
}

class _OrderEmpityState extends State<OrderEmpity> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // لون الخلفية بناءً على الوضع
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
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
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
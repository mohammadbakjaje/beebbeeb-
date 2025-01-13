import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../helper/my_colors.dart';
import '../../../widget/coustembutonm.dart';
import '../../Drawer/ theme_provider.dart';
import '../../HomePage/HomePage.dart';

class FavouriteEmpity extends StatefulWidget {
  @override
  State<FavouriteEmpity> createState() => FavouriteEmpityState();
}

class FavouriteEmpityState extends State<FavouriteEmpity> {
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
                child: Lottie.asset('images/Animation - 1736713523254.json'),
              ),
              Text(
                "The Favourite is Empty !",
                style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child: CoustemButonM(
              ontap: () {
                Navigator.of(context).pushNamed(HomePage.id);
                setState(() {});
              },
              text: "Order now !!",
              color: MyColors.buttun,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../../helper/my_colors.dart';
import '../../../../widget/coustembutonm.dart';
import '../../../Drawer/ theme_provider.dart';
import '../../../HomePage/HomePage.dart';

class FavouriteEmpityScreen extends StatefulWidget {
  @override
  State<FavouriteEmpityScreen> createState() => FavouriteEmpityScreenState();
}

class FavouriteEmpityScreenState extends State<FavouriteEmpityScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? MyColors.dark_1
          : Colors.white, // لون الخلفية بناءً على الوضع
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset('images/Animation - 1736713523254.json'),
          ),
          SizedBox(
            height: 30,
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
    );
  }
}

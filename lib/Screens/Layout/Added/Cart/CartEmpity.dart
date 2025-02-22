import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products.dart';
import '../../../../helper/my_colors.dart';
import '../../../../widget/coustembutonm.dart';
import '../../../Drawer/ theme_provider.dart';
import '../../../HomePage/HomePage.dart';
import '../../layout_screen.dart';

class CartEmpity extends StatefulWidget {
  @override
  State<CartEmpity> createState() => _CartEmpityState();
}

class _CartEmpityState extends State<CartEmpity> {
  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? MyColors.dark_1
          : Colors.white, // لون الخلفية بناءً على الوضع
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset('images/Animation - 1735467766091.json'),
            ),
            Text(
              "The Cart is Empty !",
              style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : Colors.black, // لون النص بناءً على الوضع
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

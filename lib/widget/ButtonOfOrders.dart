import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../Screens/Drawer/ theme_provider.dart';
import '../helper/my_colors.dart';


class ButtonOfOrders extends StatefulWidget {
  final String date;
  final String clock;
  final VoidCallback onPressed;

  ButtonOfOrders({
    required this.date,
    required this.clock,
    required this.onPressed,
  });

  @override
  _ButtonOfOrdersState createState() => _ButtonOfOrdersState();
}

class _ButtonOfOrdersState extends State<ButtonOfOrders> {
  Color circle1Color = MyColors.dark_2;
  Color circle2Color = MyColors.dark_2;
  Color circle3Color = MyColors.dark_2;

  void changeColor(int circleNumber) {
    setState(() {
      if (circleNumber == 1) {
        circle1Color = Colors.red;
      } else if (circleNumber == 2) {
        circle2Color = Colors.orange;
      } else if (circleNumber == 3) {
        circle3Color = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300]!,
            width: 1,
          ),
          color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(
                    fontSize: 19,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    widget.clock,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => changeColor(1),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: circle1Color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => changeColor(2),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: circle2Color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => changeColor(3),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: circle3Color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
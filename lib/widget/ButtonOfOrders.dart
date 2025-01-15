import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../Screens/Drawer/ theme_provider.dart';
import '../helper/my_colors.dart';

class ButtonOfOrders extends StatefulWidget {
  final String date;
  final String clock;
  final VoidCallback onPressed;
  final int index; // إضافة index كمعامل
  final VoidCallback onEditPressed; // زر التعديل
  final VoidCallback onDeletePressed; // زر الحذف

  ButtonOfOrders({
    required this.date,
    required this.clock,
    required this.onPressed,
    required this.index, // إضافة index كمعامل مطلوب
    required this.onEditPressed, // إضافة زر التعديل
    required this.onDeletePressed, // إضافة زر الحذف
  });

  @override
  _ButtonOfOrdersState createState() => _ButtonOfOrdersState();
}

class _ButtonOfOrdersState extends State<ButtonOfOrders> {
  late Color circle1Color;
  late Color circle2Color;
  late Color circle3Color;

  @override
  void initState() {
    super.initState();
    // تعيين الألوان بناءً على الـ index
    _setColorsBasedOnIndex(widget.index);
  }

  // دالة لتحديد الألوان بناءً على الـ index
  void _setColorsBasedOnIndex(int index) {
    setState(() {
      if (index == 1) {
        circle1Color = Colors.red;
        circle2Color = MyColors.dark_2;
        circle3Color = MyColors.dark_2;
      } else if (index == 2) {
        circle1Color = Colors.red;
        circle2Color = Colors.orange;
        circle3Color = MyColors.dark_2;
      } else if (index == 3) {
        circle1Color = Colors.red;
        circle2Color = Colors.orange;
        circle3Color = Colors.green;
      } else {
        // القيم الافتراضية إذا كان الـ index غير معروف
        circle1Color = MyColors.dark_2;
        circle2Color = MyColors.dark_2;
        circle3Color = MyColors.dark_2;
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
            color:
                themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300]!,
            width: 1,
          ),
          color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            // أزرار حالة الطلب على اليسار
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: circle1Color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
                SizedBox(height: 10), // زيادة التباعد بين الدوائر
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: circle2Color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
                SizedBox(height: 10), // زيادة التباعد بين الدوائر
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: circle3Color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
              ],
            ),
            SizedBox(width: 15), // زيادة التباعد بين الدوائر والمحتوى
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 19,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.clock,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // أزرار التعديل والحذف
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.blue,
                  ),
                  onPressed: widget.onEditPressed, // تفاعل زر التعديل
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.red,
                  ),
                  onPressed: widget.onDeletePressed, // تفاعل زر الحذف
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

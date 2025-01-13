import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../Screens/Drawer/ theme_provider.dart';
import '../helper/constants.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300]!,
            width: 1,
          ),
          color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300],
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
                color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
              ),
            ),
          ],
        ),
      ),
    );
  }
}
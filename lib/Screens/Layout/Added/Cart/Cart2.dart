import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../../helper/my_colors.dart';
import '../../../../widget/coustembutonm.dart';
import '../../../Drawer/ theme_provider.dart';

class Cart2 extends StatelessWidget {
  static String id = "Carting";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      appBar: AppBar(
        title: Text(
          "Carting",
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : MyColors.buttun,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  color: themeProvider.isDarkMode
                      ? MyColors.dark_2
                      : Colors.grey[200], // لون الكارت بناءً على الوضع
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price:",
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black, // لون النص بناءً على الوضع
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$0.00",
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black, // لون النص بناءً على الوضع
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CoustemButonM(
                                color: MyColors.buttun,
                                text: "Confirm",
                                ontap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: themeProvider
                                                .isDarkMode
                                            ? MyColors.dark_2
                                            : Colors
                                                .white, // لون الخلفية بناءً على الوضع
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: Text(
                                          "Confirm",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors
                                                    .black, // لون النص بناءً على الوضع
                                          ),
                                        ),
                                        content: Text(
                                          "Are you sure you want to buy all items?",
                                          style: TextStyle(
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors
                                                      .black), // لون النص بناءً على الوضع
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: themeProvider
                                                          .isDarkMode
                                                      ? Colors.white
                                                      : Colors
                                                          .black), // لون النص بناءً على الوضع
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Sure",
                                              style: TextStyle(
                                                  color: themeProvider
                                                          .isDarkMode
                                                      ? Colors.white
                                                      : Colors
                                                          .black), // لون النص بناءً على الوضع
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CoustemButonM(
                                color: Colors.red,
                                text: "Remove All",
                                ontap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: themeProvider
                                                .isDarkMode
                                            ? MyColors.dark_2
                                            : Colors
                                                .white, // لون الخلفية بناءً على الوضع
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: Text(
                                          "Confirm Deletion",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors
                                                    .black, // لون النص بناءً على الوضع
                                          ),
                                        ),
                                        content: Text(
                                          "Are you sure you want to delete all items?",
                                          style: TextStyle(
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors
                                                      .black), // لون النص بناءً على الوضع
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: themeProvider
                                                          .isDarkMode
                                                      ? Colors.white
                                                      : Colors
                                                          .black), // لون النص بناءً على الوضع
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: themeProvider
                                                          .isDarkMode
                                                      ? Colors.white
                                                      : Colors
                                                          .black), // لون النص بناءً على الوضع
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      color: themeProvider.isDarkMode
                          ? MyColors.dark_2
                          : Colors.grey[200], // لون الكارت بناءً على الوضع
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.shopping_cart,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black, // لون الأيقونة بناءً على الوضع
                        ),
                        title: Text(
                          "Product ${index + 1}",
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black, // لون النص بناءً على الوضع
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "\$${100 * (index + 1)}",
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white70
                                : Colors.black54, // لون النص بناءً على الوضع
                            fontSize: 16,
                          ),
                        ),
                        trailing: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkMode
                                ? MyColors.dark_1
                                : Colors
                                    .grey[300], // لون الخلفية بناءً على الوضع
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black, // لون النص بناءً على الوضع
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

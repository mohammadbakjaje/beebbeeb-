import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Drawer/ theme_provider.dart';
import '../../helper/my_colors.dart';
import '../Login/login_page.dart';

class Driver extends StatelessWidget {
  List bestSelling = [
    {
      "image": "https://via.placeholder.com/100", // رابط صورة صغيرة
      "name": "أحمد محمد",
      "phone": "0591234567",
    },
    {
      "image": "https://via.placeholder.com/100", // رابط صورة صغيرة
      "name": "علي خالد",
      "phone": "0597654321",
    },
  ];

  // دالة تسجيل الخروج
  void _logout(BuildContext context) {
    // يمكنك هنا تنفيذ أي عمليات تسجيل خروج مطلوبة
    print("تم تسجيل الخروج");

    // إعادة توجيه المستخدم إلى صفحة تسجيل الدخول (أو أي صفحة أخرى)
    Navigator.of(context).pushReplacementNamed('/login'); // تأكد من استبدال '/login' بالمسار الصحيح
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Driver",
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
          backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : MyColors.buttun,
          iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white70 : Colors.white,
          ),
          actions: [
            // زر تسجيل الخروج
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(LoginPage.id);
              }, // استدعاء دالة تسجيل الخروج
            ),
          ],
        ),
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              GridView.builder(
                itemCount: bestSelling.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // عدد الأعمدة
                  mainAxisExtent: 120, // ارتفاع الكارت
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      // يمكنك إضافة أي إجراء عند النقر على الكارت
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white, // لون الكارت
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            // صورة السائق
                            Container(
                              width: 80, // عرض الصورة
                              height: 80, // ارتفاع الصورة
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(bestSelling[i]["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // معلومات السائق
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bestSelling[i]["name"],
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  bestSelling[i]["phone"],
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode ? Colors.white70 : Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            // زر الأيقونة على الجانب الأيمن
                            Spacer(), // لدفع العناصر إلى اليمين
                            IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30,
                              ),
                              onPressed: () {



                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
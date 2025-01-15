import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/helper/local_network.dart';
import '../Drawer/ theme_provider.dart';
import '../../helper/my_colors.dart';
import '../Login/login_page.dart';
import 'ChangeStatusCubit/change_status_cubit.dart'; // تأكد من استيراد الكيوبت الصحيح
import 'ShowDriverCubit/Show_Driver_cubit.dart';
import 'ShowDriverCubit/show_driver_state.dart';

class Driver extends StatelessWidget {
  // دالة تسجيل الخروج
  void _logout(BuildContext context) {
    // يمكنك هنا تنفيذ أي عمليات تسجيل خروج مطلوبة
    print("تم تسجيل الخروج");

    // إعادة توجيه المستخدم إلى صفحة تسجيل الدخول (أو أي صفحة أخرى)
    Navigator.of(context).pushReplacementNamed(LoginPage.id);
    CacheNetwork.deleteCacheItem(key: "driver_token");
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

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
          foregroundColor:
              themeProvider.isDarkMode ? Colors.white : Colors.white,
          backgroundColor:
              themeProvider.isDarkMode ? MyColors.dark_2 : MyColors.buttun,
          iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white70 : Colors.white,
          ),
          actions: [
            // زر تسجيل الخروج
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.id);
              },
            ),
            // زر Refresh
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // إعادة تحميل البيانات
                context.read<InProgressOrdersCubit>().fetchInProgressOrders();
              },
            ),
          ],
        ),
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
        body: Container(
          padding: EdgeInsets.all(20),
          child: BlocBuilder<InProgressOrdersCubit, InProgressOrdersState>(
            builder: (context, state) {
              if (state is InProgressOrdersLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is InProgressOrdersLoaded) {
                return ListView(
                  children: [
                    GridView.builder(
                      itemCount: state.orders.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // عدد الأعمدة
                        mainAxisExtent: 120, // ارتفاع الكارت
                      ),
                      itemBuilder: (context, i) {
                        final order = state.orders[i];
                        return InkWell(
                          onTap: () {
                            // يمكنك إضافة أي إجراء عند النقر على الكارت
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: themeProvider.isDarkMode
                                ? MyColors.dark_2
                                : Colors.white, // لون الكارت
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
                                        image: NetworkImage(
                                            "https://via.placeholder.com/100"), // يمكنك تغيير هذا لاستخدام صورة الطلب
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // معلومات الطلب
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Order #${order['id']}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Total: \$${order['total_amount']}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode
                                              ? Colors.white70
                                              : Colors.grey[700],
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
                                      // استدعاء دالة تحديث حالة الطلب
                                      BlocProvider.of<UpdateOrderStatusCubit>(
                                              context)
                                          .updateOrderStatus(
                                              order['id'], 'delivered');
                                      context
                                          .read<InProgressOrdersCubit>()
                                          .fetchInProgressOrders(); // إرسال الباراميترات
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
                );
              } else if (state is InProgressOrdersError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}

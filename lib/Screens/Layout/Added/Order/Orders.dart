import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Layout/Added/Order/OrderCubit/order_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Order/OrderCubit/order_states.dart';

import '../../../../helper/my_colors.dart';
import '../../../../widget/ButtonOfOrders.dart';
import '../../../Drawer/ theme_provider.dart';
import '../../../Drawer/ِCustomDrawer.dart';
import '../EditCart/EditCartCubit/edit_cart_cubit.dart';
import 'OrderCubit/cancel_order_cubit.dart';
import 'OrderCubit/cancle_order_state.dart';
import 'OrderEmpity.dart'; // أضف هذا الاستيراد

class Orders extends StatefulWidget {
  static String id = "Orders";

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // App Bar
  void _showRightPanel(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(top: 30, right: 10),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 150,
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? MyColors.dark_2
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Status Colors:',
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order is being prepared',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order is out for delivery',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order has arrived',
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocListener<CancelOrderCubit, CancelOrderState>(
      listener: (context, state) {
        if (state is CancelOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          // يمكنك أيضًا تحديث قائمة الطلبات بعد الإلغاء
          context.read<OrdersCubit>().fetchOrders();
        } else if (state is CancelOrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor:
              themeProvider.isDarkMode ? Colors.white : Colors.white,
          backgroundColor:
              themeProvider.isDarkMode ? MyColors.dark_1 : MyColors.buttun,
          actions: [
            IconButton(
              icon: Icon(
                Icons.info,
                color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              ),
              onPressed: () {
                _showRightPanel(context);
              },
            ),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (BuildContext context, OrdersState state) {
            if (state is OrdersLoaded) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      GridView.builder(
                        itemCount: state.orders.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent:
                              140, // زيادة الارتفاع لتوفير مساحة أكبر
                          mainAxisSpacing: 10, // تباعد بين العناصر
                        ),
                        itemBuilder: (context, i) {
                          // تحديد قيمة الـ index بناءً على حالة الطلب
                          int index;
                          if (state.orders[i]["status"] == "pending") {
                            index = 1; // إذا كانت الحالة "pending"
                          } else if (state.orders[i]["status"] ==
                              "in_progress") {
                            index = 2; // إذا كانت الحالة "out_for_delivery"
                          } else if (state.orders[i]["status"] == "delivered") {
                            index = 3; // إذا كانت الحالة "delivered"
                          } else {
                            index = 0; // حالة افتراضية
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 13, right: 13, top: 10),
                            child: ButtonOfOrders(
                              date: state.orders[i]["order_date"],
                              clock: state.orders[i]["order_time"],
                              onPressed: () {},
                              index: index, // تمرير قيمة الـ index
                              onEditPressed: () {
                                // تفاعل زر التعديل
                                _editOrder(state.orders[i]);
                              },
                              onDeletePressed: () {
                                // تفاعل زر الحذف
                                _deleteOrder(state.orders[i]);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is OrdersEmpty) {
              return OrderEmpity();
            } else {
              return Center(
                child: Text("Failed to load orders"),
              );
            }
          },
        ),
      ),
    );
  }

  // دالة لتعديل الطلب
  void _editOrder(Map<String, dynamic> order) {
    // استدعاء Cubit لتحميل بيانات الطلب
    context.read<EditCartCubit>().fetchEdit(order["id"]);

    // الانتقال إلى واجهة تعديل الطلب
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<EditCartCubit>(),
          child: Text("NewScreen"),
        ),
      ),
    );
  }

  // دالة لحذف الطلب
  void _deleteOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Order"),
          content: Text("Are you sure you want to delete this order?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<CancelOrderCubit>().cancelOrder(order["id"]);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

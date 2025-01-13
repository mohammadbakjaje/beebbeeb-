import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../Drawer/ theme_provider.dart';
import '../../Drawer/ِCustomDrawer.dart';
import '../../ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import '../../ProductAndStore/ProductsCubit/Products2.dart';
import 'Cart/show_cart_cubit.dart';
import 'Cart/show_cart_states.dart';
import 'Cart/delete_cart_cubit.dart'; // الكيوبت الجديد
import 'Cart/delete_cart_states.dart'; // الحالات الجديدة
import 'Cart2.dart'; // الواجهة الفارغة
import 'CartEmpity.dart'; // الواجهة الفارغة

class Cart extends StatefulWidget {
  static String id = "Cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    context.read<ShowCartCubit>().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // لون الخلفية بناءً على الوضع
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white, // لون النص بناءً على الوضع
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white, // لون العناصر الأمامية بناءً على الوضع
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : MyColors.buttun, // لون AppBar بناءً على الوضع
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ShowCartCubit, ShowCartState>(
            listener: (context, state) {
              if (state is ShowCartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
          BlocListener<DeleteCartCubit, DeleteCartState>(
            listener: (context, state) {
              if (state is DeleteCartSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // إعادة تحميل السلة بعد الحذف
                context.read<ShowCartCubit>().fetchCart();
              } else if (state is DeleteCartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ShowCartCubit, ShowCartState>(
          builder: (context, state) {
            if (state is ShowCartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ShowCartEmpty) {
              return CartEmpity(); // عرض واجهة فارغة
            } else if (state is ShowCartLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: _buildCartItems(state.cartItems, themeProvider), // عرض المنتجات
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showFinishPurchasesDialog(themeProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: MyColors.buttun,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Finish Purchases",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ShowCartError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildCartItems(List<dynamic> cartItems, ThemeProvider themeProvider) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductDetailsCubit()
                    ..getOneProduct(item['product']["id"]),
                  child: Products2(),
                ),
              ),
            );
          },
          child: Card(
            color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200], // لون الكارت بناءً على الوضع
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "http://$ipv4/${item['product']['image']}",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'images/circular_beebbeeb-removebg-preview.png', // صورة افتراضية
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['product']['name'],
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "\$${item['price']}",
                                style: TextStyle(
                                  color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      _showConfirmationDialog(index, item['id'], themeProvider);
                    },
                    icon: Icon(
                      Icons.close,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون الأيقونة بناءً على الوضع
                      size: 25,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.grey[300], // لون الخلفية بناءً على الوضع
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<ShowCartCubit>()
                                .decrementQuantity(index);
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 16,
                            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون الأيقونة بناءً على الوضع
                          ),
                        ),
                        Text(
                          "${item['quantity']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ShowCartCubit>()
                                .incrementQuantity(index);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 16,
                            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون الأيقونة بناءً على الوضع
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(int index, int itemId, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white, // لون الخلفية بناءً على الوضع
          title: Text(
            "Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
            ),
          ),
          content: Text(
            "Are you sure you want to delete this product?",
            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DeleteCartCubit>().deleteCartItem(itemId);
              },
              child: Text(
                "Yes",
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFinishPurchasesDialog(ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white, // لون الخلفية بناءً على الوضع
          title: Text(
            "Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
            ),
          ),
          content: Text(
            "Have you finished all your purchases?",
            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Cart2(),
                ));
              },
              child: Text(
                "Yes",
                style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black), // لون النص بناءً على الوضع
              ),
            ),
          ],
        );
      },
    );
  }
}
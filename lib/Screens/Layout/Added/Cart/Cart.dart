import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Layout/layout_screen.dart';

import '../../../../helper/constants.dart';
import '../../../../helper/my_colors.dart';
import '../../../Drawer/ theme_provider.dart';
import '../../../Drawer/ِCustomDrawer.dart';
import '../../../ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import '../../../ProductAndStore/ProductsCubit/Products2.dart';
import 'CartCubit/delete_cart_cubit.dart';
import 'CartCubit/delete_cart_states.dart';
import 'CartCubit/order_check_out_state.dart';
import 'CartCubit/order_checkout_cubit.dart';
import 'CartCubit/quantity_cubit.dart';
import 'CartCubit/quantity_state.dart';
import 'CartCubit/show_cart_cubit.dart';
import 'CartCubit/show_cart_states.dart';
import 'CartCubit/total_price_cubit.dart';
import 'CartCubit/total_price_states.dart';
import 'Cart2.dart';
import 'CartEmpity.dart';
import '../Orders.dart';

class Cart extends StatefulWidget {
  static String id = "Cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : MyColors.buttun,
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
                context.read<ShowCartCubit>().fetchCart();
                context.read<TotalPriceCubit>().fetchTotalPrice(); //
              } else if (state is DeleteCartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
          BlocListener<QuantityCubit, QuantityState>(
            listener: (context, state) {
              if (state is QuantitySuccess) {
                context.read<ShowCartCubit>().fetchCart();
                context
                    .read<TotalPriceCubit>()
                    .fetchTotalPrice(); // تحديث السعر الكلي
              } else if (state is QuantityError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
          BlocListener<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              if (state is CheckoutSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LayoutScreen(),
                ));
              } else if (state is CheckoutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ShowCartCubit, ShowCartState>(
          builder: (context, state) {
            if (state is ShowCartEmpty) {
              return CartEmpity();
            } else if (state is ShowCartLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: _buildCartItems(state.cartItems, themeProvider),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<TotalPriceCubit>(context)
                              .fetchTotalPrice();
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
            color:
                themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200],
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
                                'images/circular_beebbeeb-removebg-preview.png',
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
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "\$${item['price']}",
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
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
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? MyColors.dark_1
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<QuantityCubit>(context)
                                .decreaseQuantity(item["id"], context);
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 16,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "${item['quantity']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<QuantityCubit>(context)
                                .increaseQuantity(item["id"], context);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 16,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
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

  void _showConfirmationDialog(
      int index, int itemId, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white,
          title: Text(
            "Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            "Are you sure you want to delete this product?",
            style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DeleteCartCubit>().deleteCartItem(itemId);
              },
              child: Text(
                "Yes",
                style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black),
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
        return BlocBuilder<TotalPriceCubit, TotalPriceState>(
          builder: (context, state) {
            double totalPrice = 0;
            if (state is TotalPriceLoaded) {
              totalPrice = state.totalPrice;
            }

            return AlertDialog(
              backgroundColor:
                  themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Column(
                children: [
                  Icon(
                    Icons.shopping_cart_checkout,
                    size: 50,
                    color: themeProvider.isDarkMode
                        ? MyColors.buttun
                        : MyColors.dark_1,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Confirm Purchase",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are you sure you want to complete your purchase?",
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDarkMode
                          ? Colors.white70
                          : Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? MyColors.dark_1
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        BlocBuilder<TotalPriceCubit, TotalPriceState>(
                          builder: (BuildContext context, state) {
                            if (state is TotalPriceLoaded) {
                              return Text(
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              );
                            } else if (state is TotalPriceLoading) {
                              return CircularProgressIndicator();
                            } else
                              return Text("Failed");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : MyColors.dark_1,
                    ),
                  ),
                ),
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (BuildContext context, CheckoutState state) {
                    if (state is CheckoutLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CheckoutCubit>(context).checkout();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: MyColors.buttun,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Favorite/Cubit/FavouriteCubit.dart';
import 'package:untitled1/Screens/Layout/Added/Order/OrderCubit/order_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';
import 'package:untitled1/helper/my_colors.dart';
import '../Drawer/ theme_provider.dart';
import '../HomePage/MostSells/most_sell_cubit.dart';
import 'Added/Cart/CartCubit/add_cart_states.dart';
import 'Added/Cart/CartCubit/show_cart_cubit.dart';
import 'Added/Cart/CartCubit/total_price_cubit.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, LayoutStates state) {
        // يمكنك إضافة أي تفاعلات إضافية هنا إذا لزم الأمر
      },
      builder: (BuildContext context, LayoutStates state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return BlocListener<AddCartCubit, AddCartState>(
          listener: (BuildContext context, AddCartState state) {
            if (state is AddCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AddCartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Scaffold(
            backgroundColor:
                themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
            bottomNavigationBar: Visibility(
              visible:
                  cubit.showBottomNavBar, // التحكم في ظهور BottomNavigationBar
              child: BottomNavigationBar(
                currentIndex: cubit.bottomNavIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor:
                    themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
                iconSize: 25,
                selectedItemColor: themeProvider.isDarkMode
                    ? MyColors.buttun
                    : MyColors.buttun,
                unselectedItemColor:
                    themeProvider.isDarkMode ? Colors.white70 : Colors.grey,
                onTap: (index) {
                  if (index == 0) {
                    BlocProvider.of<MostSellCubit>(context)
                        .fetchMostSellProducts();
                  }
                  if (index == 3) {
                    context.read<FavouriteCubit>().fetchFavourites();
                  }
                  if (index == 1) {
                    context.read<ShowCartCubit>().fetchCart();
                    context.read<TotalPriceCubit>().fetchTotalPrice();
                  }
                  if (index == 2) {
                    context.read<OrdersCubit>().fetchOrders();
                  }
                  cubit.changeBottomNavIndex(index: index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/home.png')),
                    label: "*",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/sss.png')),
                    label: "*",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('images/orders.png')),
                    label: "*",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "*",
                  ),
                ],
              ),
            ),
            body: cubit.layoutScreens[cubit.bottomNavIndex],
          ),
        );
      },
    );
  }
}

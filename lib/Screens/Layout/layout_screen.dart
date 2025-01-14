import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';
import 'package:untitled1/helper/my_colors.dart';
import '../Drawer/ theme_provider.dart';
import 'Added/Cart/CartCubit/add_cart_states.dart';
import 'Added/Cart/CartCubit/show_cart_cubit.dart';
import 'Added/Cart/CartCubit/total_price_cubit.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (BuildContext context, state) {
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
                  if (index == 3) {
                    cubit.fetchFavourites();
                  }
                  if (index == 2) {
                    context.read<ShowCartCubit>().fetchCart();
                    context.read<TotalPriceCubit>().fetchTotalPrice();
                  }
                  cubit.changeBottomNavIndex(index: index);
                },
                items: [
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
      listener: (BuildContext context, Object? state) {
        if (state is FavouriteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }
}

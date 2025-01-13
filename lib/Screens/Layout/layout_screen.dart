import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_states.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/show_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';
import 'package:untitled1/helper/my_colors.dart';

import '../Drawer/ theme_provider.dart';


class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // الحصول على الثيم

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
            backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
              iconSize: 25,
              selectedItemColor: themeProvider.isDarkMode ? MyColors.buttun : MyColors.buttun,
              unselectedItemColor: themeProvider.isDarkMode ? Colors.white70 : Colors.grey, 
              onTap: (index) {
                if (index == 3) {
                  cubit.fetchFavourites();
                }
                if (index == 2) {
                  BlocProvider.of<ShowCartCubit>(context).fetchCart();
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
            body: cubit.layoutScreens[cubit.bottomNavIndex],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is FavouriteErrorState) {
          // عرض رسالة خطأ إذا فشل جلب البيانات
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
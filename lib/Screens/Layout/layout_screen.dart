import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_states.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/show_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';

import '../../helper/my_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: MyColors.dark_1,
              iconSize: 25,
              selectedItemColor: MyColors.buttun,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                if (index == 3) {
                  // إذا تم الضغط على أيقونة المفضلة (index = 3)
                  cubit.fetchFavourites(); // جلب المنتجات المفضلة
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
                  icon: Icon(Icons.favorite), // أيقونة المفضلة
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

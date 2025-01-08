import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';

import '../../helper/my_colors.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (BuildContext context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: MyColors.dark_1,
            iconSize: 25,
            selectedItemColor: MyColors.buttun,
            unselectedItemColor: Colors.white,
            onTap: (index) {
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
                icon: ImageIcon(AssetImage('images/hhh.png')),
                label: "*",
              ),
            ],
          ),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled1/Screens/Drawer/model/user_model.dart';
import 'package:untitled1/Screens/HomePage/HomePage.dart';
import '../../../helper/constants.dart';
import '../../../helper/local_network.dart';
import '../Added/Cart/Cart.dart';
import '../Added/Favorite/Favourit.dart';
import '../Added/Order/Orders.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  UserModel? userModel;
  int bottomNavIndex = 0;
  bool showBottomNavBar = true; // متغير للتحكم في ظهور BottomNavigationBar
  List<Widget> layoutScreens = [HomePage(), Cart(), Orders(), Favourit()];

  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    showBottomNavBar = true; // إظهار BottomNavigationBar عند تغيير الواجهة
    emit(ChangeBottomIndexNavState());
  }

  void hideBottomNavBar() {
    showBottomNavBar = false; // إخفاء BottomNavigationBar
    emit(HideBottomNavBarState());
  }

  String? token = CacheNetwork.getCacheData(key: "token");
  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(Uri.parse("$BaseUrl/getUser"),
        headers: {"Authorization": "Bearer ${token}"});

    print(response.body);
    var responseData = jsonDecode(response.body);

    if (responseData["status"] == true) {
      emit(GetUserDataSuccsesState());
      userModel = UserModel.fromJson(data: responseData['user']);
      print(userModel!.image);
      emit(GetUserDataSuccsesState());
    } else {
      emit(FailedToGetUserDataState(errMsg: "Some thing went wrong"));
    }
  }
}

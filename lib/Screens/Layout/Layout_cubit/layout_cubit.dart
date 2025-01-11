import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled1/Screens/Drawer/model/user_model.dart';
import 'package:untitled1/Screens/HomePage/HomePage.dart';
import '../../../helper/constants.dart';
import '../../../helper/local_network.dart';
import '../Added/Cart.dart';
import '../Added/Favorite/Favourit.dart';
import '../Added/Orders.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  UserModel? userModel;
  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [HomePage(), Cart(), Orders(), Favourit()];
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomIndexNavState());
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

  List<dynamic> favouriteProducts = [];
  Future<bool> checkIfFavourite(int productId) async {
    try {
      final token = CacheNetwork.getCacheData(key: "token");
      if (token == null) {
        emit(FavouriteErrorState('Token not found'));
        return false;
      }

      final url = '$BaseUrl/favourites/check?product_id=$productId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['is_favourite'] ?? false; // إرجاع حالة المفضلة
      } else {
        emit(FavouriteErrorState('Failed to check favourite status'));
        return false;
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
      return false;
    }
  }

  Future<void> fetchFavourites() async {
    emit(FavouriteLoadingState());

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/favourites/show'),
        headers: {
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة التوكين في الـ header
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        favouriteProducts = data['data']; // استخراج البيانات
        emit(FavouriteLoadedState(favouriteProducts));
      } else {
        emit(FavouriteErrorState('Failed to load favourites'));
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
    }
  }

  Future<void> removeFromFavourites(int productId) async {
    try {
      final token = 'YOUR_USER_TOKEN'; // استبدل بتوكين المستخدم الفعلي
      final url =
          '$BaseUrl/favourites/del?product_id=$productId'; // استبدل بالرابط الفعلي

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        // إزالة المنتج من القائمة المحلية
        favouriteProducts
            .removeWhere((item) => item['product']['id'] == productId);
        emit(FavouriteLoadedState(favouriteProducts));
      } else {
        emit(FavouriteErrorState('Failed to remove from favourites'));
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
    }
  }

  Future<void> addToFavourites(int productId) async {
    try {
      final token = CacheNetwork.getCacheData(key: "token");
      if (token == null) {
        emit(FavouriteErrorState('Token not found'));
        return;
      }

      final url = '$BaseUrl/favourites/$productId';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        // إضافة المنتج إلى القائمة المحلية
        favouriteProducts.add(data['data']);
        emit(FavouriteLoadedState(favouriteProducts));
      } else {
        print("fuckyouuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
        emit(FavouriteErrorState('Failed to add to favourites'));
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
    }
  }
}

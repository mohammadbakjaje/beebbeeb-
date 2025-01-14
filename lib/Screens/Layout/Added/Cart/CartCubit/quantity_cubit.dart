import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/quantity_state.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/show_cart_cubit.dart';

import 'package:http/http.dart' as http;
import '../../../../../helper/constants.dart';
import '../../../../../helper/local_network.dart';

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(QuantityInitial());

  Future<void> increaseQuantity(int itemId, BuildContext context) async {
    emit(QuantityLoading());

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/cart/increase/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          emit(QuantitySuccess(data['msg']));
          context.read<ShowCartCubit>().fetchCart(); // إعادة تحميل السلة
        } else {
          emit(QuantityError(data['msg']));
        }
      } else {
        emit(QuantityError('Failed to increase quantity'));
      }
    } catch (e) {
      emit(QuantityError('An error occurred: $e'));
    }
  }

  Future<void> decreaseQuantity(int itemId, BuildContext context) async {
    emit(QuantityLoading());

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/cart/decrease/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          emit(QuantitySuccess(data['msg']));
          context.read<ShowCartCubit>().fetchCart(); // إعادة تحميل السلة
        } else {
          emit(QuantityError(data['msg']));
        }
      } else {
        emit(QuantityError('Failed to decrease quantity'));
      }
    } catch (e) {
      emit(QuantityError('An error occurred: $e'));
    }
  }
}

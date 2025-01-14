import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';

import '../../../../../helper/constants.dart';

import 'add_cart_states.dart';

class AddCartCubit extends Cubit<AddCartState> {
  // سيتم تمرير الـ token من الخارج
  AddCartCubit() : super(AddCartInitial());

  Future<void> addToCart(int productId) async {
    emit(AddCartLoading());

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/cart/add/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token في الـ header
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          emit(AddCartSuccess(data['msg']));
        } else {
          emit(AddCartError(data['msg']));
        }
      } else {
        emit(AddCartError('Failed to add product to cart'));
      }
    } catch (e) {
      emit(AddCartError('An error occurred: $e'));
    }
  }
}

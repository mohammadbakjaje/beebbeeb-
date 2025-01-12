import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Layout/Added/Cart/show_cart_states.dart';
import 'package:untitled1/helper/local_network.dart';

import '../../../../helper/constants.dart';

class ShowCartCubit extends Cubit<ShowCartState> {
  ShowCartCubit() : super(ShowCartInitial());

  void incrementQuantity(int index) {
    if (state is ShowCartLoaded) {
      final currentState = state as ShowCartLoaded;
      final updatedCartItems = List<dynamic>.from(currentState.cartItems);
      updatedCartItems[index]['quantity'] += 1; // زيادة الكمية
      emit(ShowCartLoaded(updatedCartItems));
    }
  }

  void decrementQuantity(int index) {
    if (state is ShowCartLoaded) {
      final currentState = state as ShowCartLoaded;
      final updatedCartItems = List<dynamic>.from(currentState.cartItems);
      if (updatedCartItems[index]['quantity'] > 1) {
        updatedCartItems[index]['quantity'] -= 1; // تقليل الكمية
        emit(ShowCartLoaded(updatedCartItems));
      }
    }
  }

  Future<void> fetchCart() async {
    emit(ShowCartLoading());

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token هنا
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          final List<dynamic> cartItems = data['cart'];
          emit(ShowCartLoaded(cartItems));
        } else {
          emit(ShowCartEmpty());
        }
      }
    } catch (e) {
      emit(ShowCartError('An error occurred: $e'));
    }
  }
}

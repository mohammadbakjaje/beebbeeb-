import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/show_cart_states.dart';
import 'package:untitled1/helper/local_network.dart';

import '../../../../../helper/constants.dart';

class ShowCartCubit extends Cubit<ShowCartState> {
  ShowCartCubit() : super(ShowCartInitial());

  Future<void> fetchCart() async {
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

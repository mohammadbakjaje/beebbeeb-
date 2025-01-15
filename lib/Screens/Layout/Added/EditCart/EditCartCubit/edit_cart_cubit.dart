import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';

import '../../../../../helper/constants.dart';
import 'edit_cart_states.dart';

class EditCartCubit extends Cubit<EditShowCartState> {
  EditCartCubit() : super(EditShowCartInitial());

  Future<void> fetchEdit(int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/orders/$orderId/edit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token هنا
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          final List<dynamic> cartItems = data['order']['items'];
          emit(EditShowCartLoaded(cartItems));
        } else {
          emit(EditShowCartEmpty());
        }
      }
    } catch (e) {
      emit(EditShowCartError('An error occurred: $e'));
    }
  }
}

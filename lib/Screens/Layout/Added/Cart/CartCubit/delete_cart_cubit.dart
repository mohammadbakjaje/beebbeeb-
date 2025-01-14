import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';

import '../../../../../helper/constants.dart';
import 'delete_cart_states.dart';

class DeleteCartCubit extends Cubit<DeleteCartState> {
  DeleteCartCubit() : super(DeleteCartInitial());

  Future<void> deleteCartItem(int itemId) async {
    emit(DeleteCartLoading());

    try {
      final response = await http.delete(
        Uri.parse('$BaseUrl/cart/remove/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token هنا
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          emit(DeleteCartSuccess(data['msg']));
        } else {
          emit(DeleteCartError(data['msg']));
        }
      } else {
        emit(DeleteCartError('Failed to delete cart item'));
      }
    } catch (e) {
      emit(DeleteCartError('An error occurred: $e'));
    }
  }
}

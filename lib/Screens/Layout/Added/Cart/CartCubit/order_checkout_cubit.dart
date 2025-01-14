import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';
import '../../../../../helper/constants.dart';
import 'order_check_out_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> checkout() async {
    emit(CheckoutLoading());

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/order/checkout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          emit(CheckoutSuccess(data['msg']));
        } else {
          emit(CheckoutError(data['msg']));
        }
      } else {
        emit(CheckoutError('Failed to checkout'));
      }
    } catch (e) {
      emit(CheckoutError('An error occurred: $e'));
    }
  }
}

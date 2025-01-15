import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';
import 'dart:convert';

import '../../../../../helper/local_network.dart';
import 'order_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  Future<void> fetchOrders() async {
    try {
      print("mmmssssssssssssssssssssssssssssssssssssm");
      final response = await http.get(
        Uri.parse('$BaseUrl/orders'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token هنا
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");

        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          final List<dynamic> orders = data['orders'];
          emit(OrdersLoaded(orders));
        } else if (data['status'] == false) {
          emit(OrdersEmpty());
        } else {
          emit(OrdersError(data['msg']));
        }
      } else {
        emit(OrdersError('Failed to load orders'));
      }
    } catch (e) {
      print(e);
      emit(OrdersError(e.toString()));
    }
  }
}

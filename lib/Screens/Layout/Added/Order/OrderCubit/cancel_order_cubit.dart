import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../helper/constants.dart';
import '../../../../../helper/local_network.dart';
import 'cancle_order_state.dart';

// States

// Cubit
class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit() : super(CancelOrderInitial());

  Future<void> cancelOrder(int orderId) async {
    emit(CancelOrderLoading()); // إظهار حالة التحميل

    try {
      final response = await http.post(
        Uri.parse('$BaseUrl/orders/$orderId/cancel'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة الـ token
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['status'] == true) {
          emit(CancelOrderSuccess(responseData['msg'])); // نجاح الإلغاء
        } else {
          emit(CancelOrderFailure(responseData['msg'])); // فشل الإلغاء
        }
      } else {
        emit(CancelOrderFailure(responseData['msg'])); // فشل الإلغاء
      }
    } catch (e) {
      emit(CancelOrderFailure('An error occurred: $e')); // خطأ غير متوقع
    }
  }
}

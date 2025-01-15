import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled1/helper/constants.dart';

abstract class UpdateOrderStatusState {}

class UpdateOrderStatusInitial extends UpdateOrderStatusState {}

class UpdateOrderStatusLoading extends UpdateOrderStatusState {}

class UpdateOrderStatusSuccess extends UpdateOrderStatusState {
  final String message;
  UpdateOrderStatusSuccess(this.message);
}

class UpdateOrderStatusFailure extends UpdateOrderStatusState {
  final String error;
  UpdateOrderStatusFailure(this.error);
}

class UpdateOrderStatusCubit extends Cubit<UpdateOrderStatusState> {
  UpdateOrderStatusCubit() : super(UpdateOrderStatusInitial());

  // دالة لتحديث حالة الطلب
  Future<void> updateOrderStatus(int orderId, String status) async {
    emit(UpdateOrderStatusLoading()); // إظهار حالة التحميل

    try {
      final url = Uri.parse('$BaseUrl/orders/$orderId/status');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'status': status});

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // إذا كان الطلب ناجحًا
        final responseData = jsonDecode(response.body);
        print(responseData);
        emit(UpdateOrderStatusSuccess(responseData['message']));
      } else {
        // إذا كان هناك خطأ في الطلب
        final responseData = jsonDecode(response.body);
        emit(UpdateOrderStatusFailure(responseData['error']));
      }
    } catch (e) {
      // إذا حدث خطأ في الاتصال
      emit(UpdateOrderStatusFailure('Failed to update order status: $e'));
    }
  }
}

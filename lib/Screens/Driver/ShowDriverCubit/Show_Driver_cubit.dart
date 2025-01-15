import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Driver/ShowDriverCubit/show_driver_state.dart';
import 'package:untitled1/helper/constants.dart';

import '../../../helper/local_network.dart';

class InProgressOrdersCubit extends Cubit<InProgressOrdersState> {
  InProgressOrdersCubit() : super(InProgressOrdersInitial());

  Future<void> fetchInProgressOrders() async {
    emit(InProgressOrdersLoading()); // إرسال حالة التحميل

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/order/get/inProgress'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "driver_token")}', // إضافة الـ token في الـ header
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          final List<dynamic> orders = data['orders'];
          emit(InProgressOrdersLoaded(orders)); // إرسال حالة النجاح مع البيانات
        } else {
          emit(InProgressOrdersError(data['msg'])); // إرسال حالة الخطأ
        }
      } else {
        emit(InProgressOrdersError(
            'Failed to load in-progress orders')); // إرسال حالة الخطأ
      }
    } catch (e) {
      emit(InProgressOrdersError(e.toString())); // إرسال حالة الخطأ
    }
  }
}

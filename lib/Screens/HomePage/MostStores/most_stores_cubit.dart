import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../helper/constants.dart';
import 'most_stores_state.dart';

class MostStoresCubit extends Cubit<MostStoresState> {
  MostStoresCubit() : super(StoresInitial());

  Future<void> fetchStores() async {
    emit(StoresLoading()); // إصدار حالة التحميل

    try {
      final response =
          await http.get(Uri.parse('$BaseUrl/products/mostfamous'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> products =
            data.cast<Map<String, dynamic>>();
        emit(StoresLoaded(products)); // إصدار حالة التحميل الناجح
      } else {
        emit(StoresError('Failed to load products')); // إصدار حالة الخطأ
      }
    } catch (e) {
      emit(StoresError('An error occurred: $e')); // إصدار حالة الخطأ
    }
  }
}

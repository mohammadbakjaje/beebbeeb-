import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';
import 'dart:convert';

import 'most_sell_state.dart';

class MostSellCubit extends Cubit<MostSellState> {
  MostSellCubit() : super(MostSellInitial());

  Future<void> fetchMostSellProducts() async {
    emit(MostSellLoading()); // إصدار حالة التحميل

    try {
      final response = await http.get(Uri.parse('$BaseUrl/products/mostSell'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> products =
            data.cast<Map<String, dynamic>>();
        emit(MostSellLoaded(products)); // إصدار حالة التحميل الناجح
      } else {
        emit(MostSellError(
            'Failed to load most sell products')); // إصدار حالة الخطأ
      }
    } catch (e) {
      emit(MostSellError('An error occurred: $e')); // إصدار حالة الخطأ
    }
  }
}

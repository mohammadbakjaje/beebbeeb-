import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';
import 'dart:convert';

import 'ad_product_state.dart';

class AdProductCubit extends Cubit<AdProductState> {
  AdProductCubit() : super(AdProductInitial());

  Future<void> fetchAdProducts() async {
    emit(AdProductLoading());

    try {
      final response = await http.get(Uri.parse('$BaseUrl/products/ad'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> products =
            data.cast<Map<String, dynamic>>();

        // استخراج روابط الصور من البيانات
        final List<String> images =
            products.map((product) => product['Ad-image'] as String).toList();

        emit(AdProductLoaded(products, images));
      } else {
        emit(AdProductError('Failed to load ad products'));
      }
    } catch (e) {
      emit(AdProductError('An error occurred: $e'));
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helper/constants.dart';
import '../../../../../helper/local_network.dart';
import 'Check_if_favourite_state.dart';

class CheckIfFavouriteCubit extends Cubit<CheckIfFavouriteState> {
  CheckIfFavouriteCubit() : super(CheckIfFavouriteInitial());

  Future<void> checkIfFavourite(int productId) async {
    emit(CheckIfFavouriteLoading()); // إصدار حالة التحميل

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/favourites/check?product_id=$productId'),
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final bool isFavourite = data['is_favourite']; // استخراج القيمة

        emit(FavouriteChecked(isFavourite)); // إصدار حالة التحقق
      } else {
// إصدار حالة خطأ مع رسالة مناسبة
        emit(FavouriteError(
            'Failed to check favourite: ${response.statusCode}'));
      }
    } catch (e) {
// إصدار حالة خطأ مع رسالة الخطأ
      emit(FavouriteError('An error occurred: $e'));
    }
  }
}

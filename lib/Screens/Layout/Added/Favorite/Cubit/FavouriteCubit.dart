import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../helper/constants.dart';
import '../../../../../helper/local_network.dart'; // تأكد من أن هذا المسار صحيح
import 'favourite_states.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<dynamic> favourites = [];

  Future<void> fetchFavourites() async {
    emit(FavouriteLoadingState()); // إرسال حالة التحميل

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/favourites/show'),
        headers: {
          'Authorization':
              'Bearer ${CacheNetwork.getCacheData(key: "token")}', // إضافة التوكين في الـ header
        },
      );

      if (response.statusCode == 200) {
        print("yess");
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        if (data["status"] == true) {
          favourites = data['favourites'];
          print(favourites);
          emit(FavouriteLoadedState(favourites));
        } else {
          emit(FavouriteEmpity()); // إرسال حالة فارغة
        }
      } else {
        emit(
            FavouriteErrorState('Failed to load favourites')); // إرسال حالة خطأ
      }
    } catch (e) {
      emit(FavouriteErrorState(
          'An error occurred: $e')); // إرسال حالة خطأ مع التفاصيل
    }
  }
}

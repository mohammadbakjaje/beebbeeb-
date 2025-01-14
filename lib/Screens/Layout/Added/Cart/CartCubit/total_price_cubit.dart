import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/total_price_states.dart';
import 'package:untitled1/helper/local_network.dart';
import '../../../../../helper/constants.dart';

class TotalPriceCubit extends Cubit<TotalPriceState> {
  TotalPriceCubit() : super(TotalPriceInitial());

  Future<void> fetchTotalPrice() async {
    emit(TotalPriceLoading());

    try {
      final response = await http.get(
        Uri.parse('$BaseUrl/cart/totalPrice'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(",,,,,,,,,,,,,,,,,,,,,,,,,");
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          final double totalPrice = data['total_price'].toDouble();
          print("totalPrice $totalPrice");
          emit(TotalPriceLoaded(totalPrice));
        } else {
          emit(TotalPriceError(data['msg']));
        }
      } else {
        emit(TotalPriceError('Failed to fetch total price'));
      }
    } catch (e) {
      emit(TotalPriceError('An error occurred: $e'));
    }
  }
}

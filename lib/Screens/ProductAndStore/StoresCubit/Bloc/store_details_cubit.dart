import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/store_details_states.dart';
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/stores_model.dart';
import 'dart:convert';

import '../../../../helper/constants.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  StoreDetailsCubit() : super(StoreDetailsInitialState());
  StoreModel? store;

  Future<void> getOneStore(int StoreId) async {
    emit(GetOneStoreLoadingState());
    final response = await http.get(Uri.parse('$BaseUrl/one-store/$StoreId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      store = StoreModel.fromJson(data);
      emit(GetOneStoreSuccessState());
    } else {
      emit(GetOneStoreFailedState("Failed to get the product"));
      throw Exception('Failed to load product details');
    }
  }
}

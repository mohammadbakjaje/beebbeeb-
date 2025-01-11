import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/store_details_states.dart';
import '../../../../helper/constants.dart';
import 'stores_model.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  StoreDetailsCubit() : super(StoreDetailsInitialState());

  void fetchStoreDetails(int storeId) async {
    emit(GetStoreDetailsLoadingState());

    try {
      final response = await http.get(Uri.parse('$BaseUrl/one-store/$storeId'));
      print(response.body);
      print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final store = StoreModel.fromJson(jsonData);
        print(store);
        emit(GetStoreDetailsSuccessState(store));
      } else {
        emit(GetStoreDetailsErrorState(
            'Failed to load store details: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetStoreDetailsErrorState('Error: ${e.toString()}'));
    }
  }
}

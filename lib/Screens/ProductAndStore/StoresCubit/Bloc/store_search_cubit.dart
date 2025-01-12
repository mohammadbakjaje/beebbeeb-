import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/store_search_states.dart';
import 'dart:convert';

import '../../../../helper/constants.dart';

class SearchStoreCubit extends Cubit<SearchStoreStates> {
  SearchStoreCubit() : super(SearchStoreInitial());

  Future<void> searchStore({required String query}) async {
    if (query.isEmpty) {
      emit(SearchStoreInitial());
      return;
    }

    emit(SearchStoreLoading());

    try {
      final response =
          await http.get(Uri.parse("$BaseUrl/stores/search/$query"));
      print("mmmmmmmmmmmmmmmmmmmmmm");
      if (response.statusCode == 200) {
        print("$BaseUrl/store/search/$query");
        final List<dynamic> data = json.decode(response.body);
        print(data);
        emit(SearchStoreSuccess(data));
      } else {
        emit(SearchStoreError("Failed to load search results"));
      }
    } catch (e) {
      emit(SearchStoreError(e.toString()));
    }
  }
}

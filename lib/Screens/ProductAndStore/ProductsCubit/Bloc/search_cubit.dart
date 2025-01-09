import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/search_states.dart';

import '../../../../helper/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final response =
          await http.get(Uri.parse("$BaseUrl/products/search/$query"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        emit(SearchSuccess(data));
      } else {
        emit(SearchError("Failed to load search results"));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

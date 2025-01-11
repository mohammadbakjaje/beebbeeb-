import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/products_by_catigories_states.dart';
import '../../../../helper/constants.dart';
import '../../ProductsCubit/Bloc/products_models.dart';

class ProductsByCatigoriesCubit extends Cubit<ProductsByCatigoriesStatesState> {
  ProductsByCatigoriesCubit() : super(ProductsByCatigoriesInitialState());

  void fetchProductsByCategory(int categoryId) async {
    emit(GetProductsByCatigoriesLoadingState());

    try {
      final response =
          await http.get(Uri.parse('$BaseUrl/categories/$categoryId/products'));
      print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final products =
            jsonData.map((product) => ProductModel.fromJson(product)).toList();
        print("........................................................");
        emit(GetProductsByCatigoriesSuccessState(products));
      } else {
        emit(GetProductsByCatigoriesErrorState(
            'Failed to load products: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetProductsByCatigoriesErrorState('Error: ${e.toString()}'));
    }
  }
}

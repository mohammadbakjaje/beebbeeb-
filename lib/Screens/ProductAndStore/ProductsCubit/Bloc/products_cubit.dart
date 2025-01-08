import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Login/bloc/login_state.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products2.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/products_models.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/prooducts_states.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';
import '../../../../helper/local_network.dart';

class ProductCubit extends Cubit<ProductsState> {
  List<dynamic>? data;
  ProductModel? product;
  ProductCubit() : super(ProductsInitialState());
  ProductModel? productModel;
  String? token = CacheNetwork.getCacheData(key: "token");
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    final response = await http.get(Uri.parse("$BaseUrl/products-all-PP"));

    if (response.statusCode == 200) {
      emit(GetProductsSuccessState());
      data = json.decode(response.body);
      print(data);
      return json.decode(response.body);
    } else {
      emit(GetProductsFailedState("failed to load products"));
      throw Exception('Failed to load data');
    }
  }
}

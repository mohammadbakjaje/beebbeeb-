import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Login/bloc/login_state.dart';
import 'package:untitled1/Screens/ProductAndStore/Products2.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/products_models.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/prooducts_states.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';
import '../../../helper/local_network.dart';

class ProductCubit extends Cubit<ProductsState> {
  List<dynamic>? data;
  ProductCubit() : super(ProductsInitialState());
  ProductModel? productModel;
  String? token = CacheNetwork.getCacheData(key: "token");
  void getProducts() async {
    emit(getProducatsLoadingState());
    final response = await http.get(Uri.parse("$BaseUrl/products-all-PP"));

    if (response.statusCode == 200) {
      emit(getProducatsSuccessState());
      data = json.decode(response.body);
      print(data);
      return json.decode(response.body);
    } else {
      emit(getProducatsFailedState("failed to load products"));
      throw Exception('Failed to load data');
    }
  }
}

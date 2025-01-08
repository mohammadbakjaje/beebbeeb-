import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/product_details_states.dart';
import 'dart:convert';

import '../../../../helper/constants.dart';
import '../../../../helper/local_network.dart';
import 'products_models.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());
  ProductModel? product;

  String? token = CacheNetwork.getCacheData(key: "token");

  Future<void> getOneProduct(int productId) async {
    emit(GetOneProductLoadingState());
    final response =
        await http.get(Uri.parse('$BaseUrl/one-product/$productId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      product = ProductModel.fromJson(data[0]);
      emit(GetOneProductSuccessState());
    } else {
      emit(GetOneProductFailedState("Failed to get the product"));
      throw Exception('Failed to load product details');
    }
  }
}

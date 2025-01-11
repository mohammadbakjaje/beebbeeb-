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
  bool isFavourite = false;

  Future<void> getOneProduct(int productId) async {
    emit(GetOneProductLoadingState());
    final response =
        await http.get(Uri.parse('$BaseUrl/one-product/$productId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      product = ProductModel.fromJson(data[0]);
      await checkIfFavourite(productId);
      emit(GetOneProductSuccessState());
      print(isFavourite);
    } else {
      emit(GetOneProductFailedState("Failed to get the product"));
      throw Exception('Failed to load product details');
    }
  }

  Future<void> checkIfFavourite(int productId) async {
    try {
      print("mmmmmmmmmmmmm");

      final url = '$BaseUrl/favourites/check?product_id=$productId';
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        print("mmmmmmmmmmmmmmmmmmmmminside f");
        isFavourite = data['is_favourite'];
        print(isFavourite); // تحديث حالة المفضلة
        emit(FavouriteCheckedState(isFavourite));
      } else {
        print("ssssssssssssssssssssssssssssssssssssssss");
        emit(FavouriteCheckedState(false));
      }
    } catch (e) {
      emit(FavouriteCheckedState(false));
    }
  }
}

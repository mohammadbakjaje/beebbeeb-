import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../helper/constants.dart';
import '../../../../../helper/local_network.dart';
import 'add_remove_states.dart';

class AddRemoveFavouriteCubit extends Cubit<AddRemoveFavouriteState> {
  AddRemoveFavouriteCubit() : super(AddRemoveFavouriteInitial());
  List<dynamic> favouriteProducts = [];

  Future<void> removeFromFavourites(int productId) async {
    try {
      final url = '$BaseUrl/favourites/del?product_id=$productId';

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200) {
        emit(RemoveFavouriteSuccessState(
            "Remove product from favourite successfully"));
      } else {
        emit(FavouriteErrorState('Failed to remove from favourites'));
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
    }
  }

  Future<void> addToFavourites(int productId) async {
    try {
      final url = '$BaseUrl/favourites/$productId';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${CacheNetwork.getCacheData(key: "token")}',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        emit(AddFavouriteSuccessState(
            "Product added to favourite successfully"));
      } else {
        emit(FavouriteErrorState('Failed to add to favourites'));
      }
    } catch (e) {
      emit(FavouriteErrorState('An error occurred: $e'));
    }
  }
}

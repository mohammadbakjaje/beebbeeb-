import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../helper/constants.dart';
import '../../../../helper/local_network.dart';
import '../Stores.dart';
import 'stores_model.dart';
import 'stores_State.dart';

class StoresCubit extends Cubit<StoresState> {
  List<dynamic>? data;
  List<StoreModel> stores = [];
  StoresCubit() : super(StoresInitialState());
  StoreModel? storeModel;
  String? token = CacheNetwork.getCacheData(key: "token");

  Future<void> getStores() async {
    emit(GetStoresLoadingState());
    final response = await http.get(Uri.parse("$BaseUrl/stores"));

    if (response.statusCode == 200) {
      emit(GetStoresSuccessState());
      data = json.decode(response.body);
      print(data);
      for (var item in data!) {
        stores.add(StoreModel.fromJson(item));
      }
      return json.decode(response.body);
    } else {
      emit(GetStoresFailedState("failed to load products"));
      throw Exception('Failed to load data');
    }
  }
}
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled1/Screens/Drawer/model/user_model.dart';
import '../../../helper/constants.dart';
import '../../../helper/local_network.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  UserModel? userModel;
  String? token = CacheNetwork.getCacheData(key: "token");
  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(Uri.parse("$BaseUrl/getUser"),
        headers: {"Authorization": "Bearer ${token}"});

    print(response.body);
    var responseData = jsonDecode(response.body);

    print(responseData);
    if (responseData["status"] == true) {
      emit(GetUserDataSuccsesState());
      userModel = UserModel.fromJson(data: responseData['user']);
      emit(GetUserDataSuccsesState());
    } else {
      emit(FailedToGetUserDataState(errMsg: "Some thing went wrong"));
    }
  }
}

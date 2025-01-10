import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';
import 'dart:convert';

import '../../../helper/constants.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    emit(ChangePasswordLoading());

    final url = Uri.parse('$BaseUrl/change-password');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        }),
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print("Oldtoken ${CacheNetwork.getCacheData(key: "token")}");
      if (response.statusCode == 200 && responseData["status"] == true) {
        CacheNetwork.insertToCache(key: "token", value: responseData["token"]);

        print("Newtoken ${CacheNetwork.getCacheData(key: "token")}");
        emit(ChangePasswordSuccess(message: 'password changed successful!'));
      } else {
        throw (responseData['msg']);
      }
    } catch (e) {
      emit(ChangePasswordFailure(error: e.toString()));
    }
  }
}

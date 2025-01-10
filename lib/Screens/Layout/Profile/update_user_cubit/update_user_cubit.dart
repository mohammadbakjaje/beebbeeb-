import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Layout/Profile/update_image_cubit/update_Image_states.dart';
import 'package:untitled1/Screens/Layout/Profile/update_user_cubit/update_user_states.dart';
import 'package:untitled1/helper/local_network.dart';

import '../../../../helper/constants.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    emit(UpdateUserLoading());
    try {
      final token = CacheNetwork.getCacheData(key: "token");
      final response = await http.put(
        Uri.parse('$BaseUrl/updateUser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "first-name": firstName,
          "last-name": lastName,
          "phone": phone,
        }),
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        emit(UpdateUserSuccess("User updated successfully"));
      } else {
        emit(UpdateUserFailure("Failed to update user"));
      }
    } catch (e) {
      emit(UpdateUserFailure("Error: $e"));
    }
  }
}

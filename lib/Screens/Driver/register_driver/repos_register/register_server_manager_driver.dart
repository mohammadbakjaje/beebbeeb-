import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../helper/constants.dart';
import '../../../../helper/local_network.dart';
import '../model_register/register_model_driver.dart';

class DriverRegisterServerManager {
  Future<DriverRegisterModel> registerDriver(String firstName, String lastName,
      String phone, String password, String confirmPassword) async {
    final http.Response response = await http.post(
      Uri.parse(
          '$BaseUrl/driver/register?firstName=$firstName&lastName=$lastName&phone=$phone&password=$password&password_confirmation=$confirmPassword'),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["status"] == true) {
      await CacheNetwork.insertToCache(key: "driver_token", value: data["token"]);
      return DriverRegisterModel.fromJson(data);
    } else {
      throw (data["msg"]);
    }
  }
}
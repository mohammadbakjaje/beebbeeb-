import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/register/model/register_model.dart';

import '../../../helper/constants.dart';

class RegisterServerManager {
  String BaseUrl = 'http://$ipv4/api';

  Future<RegisterModel> register(String firstName, String lastName,
      String phone, String password, String confirmPassword) async {
    print("hello");
    final http.Response response = await http.post(
      Uri.parse(
          '$BaseUrl/register?firstName=$firstName&lastName=$lastName&phone=$phone&password=$password&password_confirmation=$confirmPassword'),
    );
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["status"] == true) {
      return RegisterModel.fromJson(data);
    } else {
      throw (data["msg"]);
    }
  }
}

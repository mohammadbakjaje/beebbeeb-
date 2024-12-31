import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class LoginServerManager {
  String BaseUrl = 'http://127.0.0.1:8000/api';

  Future<LoginModel> login(String phone, String password) async {
    print("hello");
    final http.Response response = await http.post(
      Uri.parse('$BaseUrl/login?phone=$phone&password=$password'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(data);
    } else {
      throw (data["message"]);
    }
  }
}

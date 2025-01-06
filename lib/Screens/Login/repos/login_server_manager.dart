import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled1/helper/local_network.dart';

import '../../../helper/constants.dart';
import '../model/login_model.dart';

class LoginServerManager {
  Future<LoginModel> login(String phone, String password) async {
    print("hello");
    final http.Response response = await http.post(
      Uri.parse('$BaseUrl/login?phone=$phone&password=$password'),
    );
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["status"] == true) {
      await CacheNetwork.insertToCache(key: "token", value: data["token"]);
      print(data["token"]);
      return LoginModel.fromJson(data);
    } else {
      throw (data["msg"]);
    }
  }
}

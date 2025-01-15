import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';

import '../../../../helper/local_network.dart';

class DriverLoginServerManager {
  Future<void> DriverloginDriver(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse('$BaseUrl/driver/login?&phone=$email&password=$password'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data["status"] == true) {
        await CacheNetwork.insertToCache(
            key: "driver_token", value: data["token"]);
        return;
      } else {
        throw data["msg"];
      }
    } else {
      throw "Failed to register driver";
    }
  }
}

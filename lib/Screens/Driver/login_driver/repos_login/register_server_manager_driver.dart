import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/helper/constants.dart';

class DriverLoginServerManager {
  Future<void> loginDriver(String email, String password, String license, String carType) async {
    final http.Response response = await http.post(
      Uri.parse('$BaseUrl/driver/register'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'license': license,
        'carType': carType,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data["status"] == true) {
        return;
      } else {
        throw data["msg"];
      }
    } else {
      throw "Failed to register driver";
    }
  }
}
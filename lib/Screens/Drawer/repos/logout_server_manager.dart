import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Drawer/model/logout_model.dart';
import 'package:untitled1/helper/local_network.dart';

import '../../../helper/constants.dart';

class LogoutServerManager {
  String BaseUrl = 'http://$ipv4/api';

  Future<LogoutModel> logout(String token) async {
    final http.Response response = await http.post(Uri.parse('$BaseUrl/logout'),
        headers: {"Authorization": "Bearer ${token}"});
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["status"] == true) {
      await CacheNetwork.deleteCacheItem(key: "token");
      return LogoutModel.fromJson(data);
    } else {
      throw (data["msg"]);
    }
  }
}

import 'package:get_storage/get_storage.dart';
import 'local_network.dart';

final box = GetStorage();
final String ipv4 = "192.168.216.88:80";
final String BaseUrl = 'http://$ipv4/api';
final String productsSearch = "products";
final String storesSearch = "stores";
String removeChar(String input, String charToRemove) {
  String result = "";
  for (int i = 0; i < input.length; i++) {
    if (input[i] != charToRemove) {
      result += input[i];
    }
  }
  return result;
}

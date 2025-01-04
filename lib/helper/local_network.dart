import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPreferences;
  static Future cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //set - get -delete -clear
  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getCacheData({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }

  static Future<bool> deleteCacheItem({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearCache() async {
    return await sharedPreferences.clear();
  }
}

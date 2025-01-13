import 'package:flutter/material.dart';
import 'package:untitled1/helper/local_network.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = CacheNetwork.getBoolCacheData(key: "isDark")==null? true:CacheNetwork.getBoolCacheData(key: "isDark");

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if(CacheNetwork.getBoolCacheData(key: "isDark")==null){
      CacheNetwork.insertBoolToCache(key: "isDark", value: _isDarkMode);
    }
      _isDarkMode = !_isDarkMode;
    CacheNetwork.insertBoolToCache(key: "isDark", value: _isDarkMode);
    notifyListeners();
    }

  }

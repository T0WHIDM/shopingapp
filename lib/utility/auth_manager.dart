import 'package:flutter/material.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _sharedPref = locator.get();

  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);

  static void saveToken(String token) {
    _sharedPref.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifire.value = null;
  }

  static bool isLogedIn() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}

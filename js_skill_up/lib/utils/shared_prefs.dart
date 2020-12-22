import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static setValue(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      try {
        value = json.encode(value);
      } on JsonUnsupportedObjectError {
        print('Dev Error: Unsupported object to be parsed');
        return;
      } catch (e) {
        print('Something unexpected happened.\n $e');
      }
      await prefs.setString(key, value);
    }
  }

  static getValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.get(key);
  }

  static clear() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}

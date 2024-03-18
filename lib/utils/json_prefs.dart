
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class JsonPrefsFile {
  JsonPrefsFile(this.name);
  final String name;

  //this will be used to load data from SharedPreferences

  Future<Map<String, dynamic>> load() async {
    final p = (await SharedPreferences.getInstance()).getString(name);

    return Map<String, dynamic>.from(jsonDecode(p ?? '{}'));
  }

  //this will be used to save data to SharedPreferences

  Future<void> save(Map<String, dynamic> data) async {
    await (await SharedPreferences.getInstance()).setString(name, jsonEncode(data));
  }
}

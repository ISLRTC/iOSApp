import 'dart:convert';

import 'package:islrtc/infra/appUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _localStorage;

  Future<bool> remove({required String key}) async {
    _localStorage = await SharedPreferences.getInstance();

    return await _localStorage.remove(key);
  }

  Future<bool> write({required String key, required Word value}) async {
    _localStorage = await SharedPreferences.getInstance();

    return await _localStorage.setString(key, jsonEncode(value));
  }

  Future<List<Word>> allFavoriteWords() async {
    List<Word> output = [];

    _localStorage = await SharedPreferences.getInstance();

    Set<String> keys = _localStorage.getKeys();

    for (var key in keys) {
      String? value = _localStorage.getString(key);

      try {
        output.add(Word.fromJson(jsonDecode(value!)));
      } catch (e) {
        //Empty
      }
    }

    return output;
  }

  Future<bool> isInFavorites({required String key}) async {
    _localStorage = await SharedPreferences.getInstance();

    return _localStorage.containsKey(key);
  }
}

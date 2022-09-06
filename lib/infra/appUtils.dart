import 'dart:convert';

import 'package:flutter/material.dart';

class Word {
  int? id;
  String? title;
  String? url;

  Word(this.id, this.title, this.url);
  factory Word.fromJson(dynamic json) {
    return Word(json["id"], json["title"], json["url"]);
  }
}

class AppUtils {
  Future<List<Word>> loadJsonFromFile(
      {String? filename, String? language, BuildContext? context}) async {
    String jsonCode = await DefaultAssetBundle.of(context!).loadString(
        "assets/data/${language!.toLowerCase()}/${filename!.toLowerCase()}.json");

    final data = jsonDecode(jsonCode);
    List<Word> temp =
        List<Word>.from(data.map((model) => Word.fromJson(model)));

    return temp;
  }
}

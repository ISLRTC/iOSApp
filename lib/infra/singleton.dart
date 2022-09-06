import 'package:flutter/material.dart';
import 'package:islrtc/infra/appUtils.dart';
import 'package:islrtc/infra/constants.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  @protected
  Languages language = Languages.english;

  Languages get currentLanguage => language;

  void setLanguage(Languages newLanguage) {
    language = newLanguage;
  }

  @protected
  String category = "";

  String get selectedCategory => category;

  void setCategory(String newCategory) {
    category = newCategory;
  }

  @protected
  Word word = Word(0, "", "");

  Word get selectedWord => word;

  void setWord(Word newWord) {
    word = newWord;
  }

  Singleton._internal();
}

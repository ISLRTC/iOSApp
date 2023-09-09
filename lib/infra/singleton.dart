import 'package:flutter/material.dart';
import 'package:islrtc/infra/appUtils.dart';
import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/word_model.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  @protected
  List<ISLRTCWord> words = [];

  List<ISLRTCWord> get listOfWords => words;

  void setWords(List<ISLRTCWord> newWords) {
    words = newWords;
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

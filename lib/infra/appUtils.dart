import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/word_model.dart';

class Word {
  int? id;
  String? title;
  String? url;

  Word(this.id, this.title, this.url);
  factory Word.fromJson(dynamic json) {
    dynamic tempId = json["id"];
    if (tempId.runtimeType == String) {
      return Word(int.parse(tempId), json["title"], json["url"]);
    } else {
      return Word(tempId, json["title"], json["url"]);
    }
  }

  Map toJson() {
    return {"id": id, "title": title, "url": url};
  }
}

class AppUtils {
  Future<List<Word>> loadJsonFromFile(
      {String? filename, String? language, BuildContext? context}) async {
    String filePath =
        "assets/data/${language!.toLowerCase()}/${filename!.toLowerCase()}.json";
    String jsonCode =
        await DefaultAssetBundle.of(context!).loadString(filePath);

    final data = jsonDecode(jsonCode);
    List<Word> temp =
        List<Word>.from(data.map((model) => Word.fromJson(model)));

    return temp;
  }

  Future<void> launchUrlInBrowser(String? url) async {
    if (!await launchUrl(Uri(path: Uri.encodeFull(url!)))) {
      throw 'Could not launch $url';
    }
  }

  void onShare(BuildContext context, String? url, String? title) async {
    final box = context.findRenderObject() as RenderBox?;

    // subject is optional but it will be used
    // only when sharing content over email
    await Share.share(url ?? "",
        subject: title ?? "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

class ISLRTCWordUtils {
  static List<String> getCategoriesForLanguage(
      String language, List<ISLRTCWord> words) {
    List<String> categories = List<String>.from(words
        .map((e) => language == Languages.english.name
            ? e.categoryEnglish
            : e.categoryHindi)
        .toSet()
        .toList());
    categories.sort(
      (a, b) => a.compareTo(b),
    );
    return categories;
  }

  static List<Word> getWordsForCategory(
      String language, String category, List<ISLRTCWord> words) {
    List<Word> foundWords = List<Word>.from(words
        .where((element) =>
            (language == Languages.english.name
                ? element.categoryEnglish
                : element.categoryHindi) ==
            category)
        .map((e) => Word(
            e.id,
            language == Languages.english.name ? e.wordEnglish : e.wordHindi,
            e.videoUrlEnglish))
        .toSet()
        .toList());

    foundWords.sort(
      (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
    );

    return foundWords;
  }

  static List<Word> getWordFromISLRTCWords(
      String language, List<ISLRTCWord> words) {
    List<Word> foundWords = List<Word>.from(words
        .map((e) => Word(
            e.id,
            language == Languages.english.name ? e.wordEnglish : e.wordHindi,
            e.videoUrlEnglish))
        .toSet()
        .toList());

    foundWords.sort(
      (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
    );
    return foundWords;
  }

  static Future<List<Word>> searchWord(String searchText, String language,
      String category, List<ISLRTCWord> words) async {
    List<Word> allWords = category.trim().isEmpty
        ? getWordFromISLRTCWords(language, words)
        : getWordsForCategory(language, category, words);

    if (searchText.isNotEmpty) {
      if (language == Languages.english.name) {
        List<Word> foundWords = (allWords.where((element) {
          return (element.title!.toLowerCase())
              .contains(searchText.toLowerCase());
        })).toList();

        foundWords.sort(
          (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
        );
        return foundWords;
      }

      List<Word> foundWords = (allWords.where((element) {
        return (element.title ?? '').contains(searchText);
      })).toList();

      foundWords.sort(
        (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
      );
      return foundWords;
    }

    return allWords
        .where((element) => (element.title ?? '').isNotEmpty)
        .toList();
  }
}

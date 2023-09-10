import 'dart:convert';

import 'package:change_case/change_case.dart';

List<ISLRTCWord> ISLRTCWordFromJson(String str) =>
    List<ISLRTCWord>.from(json.decode(str).map((x) => ISLRTCWord.fromJson(x)));

class ISLRTCWord {
  ISLRTCWord({
    this.id,
    this.categoryEnglish,
    this.categoryHindi,
    this.wordEnglish,
    this.wordHindi,
    this.videoUrlEnglish,
    this.videoUrlHindi,
    this.isDisabled,
  });

  int? id;
  String? categoryEnglish;
  String? categoryHindi;
  String? wordEnglish;
  String? wordHindi;
  String? videoUrlEnglish;
  String? videoUrlHindi;
  bool? isDisabled;

  factory ISLRTCWord.fromJson(Map<String, dynamic> json) => ISLRTCWord(
      id: json["Id"],
      categoryEnglish: json["category_english"].toString().toSentenceCase(),
      categoryHindi: json["category_hindi"],
      wordEnglish: json["word_english"].toString().toSentenceCase(),
      wordHindi: json["word_hindi"],
      videoUrlEnglish: json["video_url_english"],
      videoUrlHindi: json["video_url_hindi"],
      isDisabled: json["isDisabled"] == 0 ? false : true);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "category_english": categoryEnglish,
        "category_hindi": categoryHindi,
        "word_english": wordEnglish,
        "word_hindi": wordHindi,
        "video_url_english": videoUrlEnglish,
        "video_url_hindi": videoUrlHindi,
        "isDisabled": isDisabled,
      };
}

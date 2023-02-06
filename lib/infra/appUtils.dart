import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islrtc/infra/singleton.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

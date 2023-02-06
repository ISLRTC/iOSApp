import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/constants.dart';

import '../components/AppScaffold.dart';
import '../components/Common.dart';
import '../infra/appUtils.dart';
import '../infra/singleton.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchText = "";
  final _selectedLanguage = Singleton().currentLanguage;

  void setSearchText(String text) {
    setState(() {
      _searchText = text.toLowerCase();
    });
  }

  Future<List<Word>> getAllWords(
      {Languages language = Languages.english, BuildContext? context}) async {
    List<Word> temp = [];

    String jsonCode = await DefaultAssetBundle.of(context!).loadString(
        "assets/data/words_json/all_${language.name.toLowerCase()}.json");

    final data = jsonDecode(jsonCode);
    temp.addAll(List<Word>.from(data.map((model) => Word.fromJson(model))));

    return temp;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return AppScaffold(
      showAppBar: true,
      pageTitle: "Search",
      hideAppBarActionButtons: [0],
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Common().searchBox(onChange: setSearchText),
        Expanded(
            child: FutureBuilder(
                future: getAllWords(
                    context: buildContext, language: _selectedLanguage),
                builder: (context, snapshot) => snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => (snapshot
                                        .data![index].title ??
                                    "")
                                .contains(_searchText)
                            ? Common().listTile(
                                title: snapshot.data![index].title ?? "",
                                icon: const Icon(Icons.chevron_right_rounded),
                                index: index,
                                onClick: (itemIndex) => {
                                  Singleton()
                                      .setWord(snapshot.data![itemIndex]),
                                  Navigator.pushNamed(context, "/wordDetail")
                                },
                              )
                            : Container())
                    : const Center(child: CircularProgressIndicator())))
      ]),
    );
  }
}

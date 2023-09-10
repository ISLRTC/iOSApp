import 'package:flutter/material.dart';
import 'package:islrtc/infra/appUtils.dart';
import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/singleton.dart';
import 'package:islrtc/infra/word_model.dart';

import '../components/AppScaffold.dart';
import '../components/Common.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  List<String> allCategories = [];
  final _selectedLanguage = Singleton().currentLanguage.name;
  List<ISLRTCWord> _words = Singleton().listOfWords;

  Future<List<String>> getCategories(BuildContext context) async {
    String jsonCode =
        await DefaultAssetBundle.of(context).loadString(DATABASE_PATH);

    if (_words.isEmpty) {
      List<ISLRTCWord> words = ISLRTCWordFromJson(jsonCode);
      if (words.isNotEmpty) {
        _words = words;
        Singleton().setWords(words);
      }
    }

    allCategories =
        ISLRTCWordUtils.getCategoriesForLanguage(_selectedLanguage, _words);

    return allCategories;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        pageTitle: "Categories",
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getCategories(context),
                  builder: (context, snapshot) => snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => Common().listTile(
                                title: snapshot.data![index],
                                icon: const Icon(Icons.chevron_right_rounded),
                                index: index,
                                onClick: (itemIndex) => {
                                  Singleton()
                                      .setCategory(allCategories[itemIndex]),
                                  Navigator.pushNamed(context, "/words")
                                },
                              ))
                      : const Center(child: CircularProgressIndicator())),
            ),
          ],
        ));
  }
}

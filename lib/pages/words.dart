import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/infra/singleton.dart';

import '../components/AppScaffold.dart';
import '../components/Common.dart';
import '../infra/appUtils.dart';

class Words extends StatelessWidget {
  Words({super.key});

  final _selectedLanguage = Singleton().currentLanguage.name;
  final _selectedCategory = Singleton().selectedCategory;
  List<Word> allWords = [];

  Future<List<Word>> getAllWords({BuildContext? context}) async {
    allWords = await AppUtils().loadJsonFromFile(
        context: context,
        filename: _selectedCategory,
        language: _selectedLanguage);

    return allWords;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: true,
      pageTitle: "Words",
      body: FutureBuilder(
        future: getAllWords(context: context),
        builder: (context, snapshot) =>
            snapshot.hasData && snapshot.connectionState == ConnectionState.done
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Common().listTile(
                          title: snapshot.data?[index].title ?? "",
                          //context: context,
                          icon: const Icon(Icons.share_outlined),
                          index: index,
                          onClick: (itemIndex) => {
                            Singleton().setWord(allWords[itemIndex]),
                            Navigator.pushNamed(context, "/wordDetail")
                          },
                          //namedRoute: "/wordDetail"),
                        ))
                : const CircularProgressIndicator(),
      ),
    );
  }
}

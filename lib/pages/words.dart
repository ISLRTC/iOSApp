import 'package:flutter/material.dart';
import 'package:islrtc/infra/singleton.dart';
import 'package:share_plus/share_plus.dart';

import '../components/AppScaffold.dart';
import '../components/Common.dart';
import '../infra/appUtils.dart';

class Words extends StatelessWidget {
  Words({super.key});

  final _selectedLanguage = Singleton().currentLanguage.name;
  final _selectedCategory = Singleton().selectedCategory;
  final _words = Singleton().listOfWords;
  final List<Word> allWords = [];

  Future<List<Word>> getAllWords({BuildContext? context}) async {
    allWords.clear();
    allWords.addAll(ISLRTCWordUtils.getWordsForCategory(
        _selectedLanguage, _selectedCategory, _words));

    return Future.value(allWords);
  }

  void onShare(BuildContext context, String? url, String? title) async {
    final box = context.findRenderObject() as RenderBox?;

    // subject is optional but it will be used
    // only when sharing content over email
    await Share.share(url ?? "",
        subject: title ?? "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext buildContext) {
    return AppScaffold(
      showAppBar: true,
      pageTitle: _selectedCategory,
      body: FutureBuilder(
        future: getAllWords(context: buildContext),
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
                          onIconClick: (itemIndex) => {
                            AppUtils().onShare(
                                buildContext,
                                "https://youtube.com/${allWords[itemIndex].url}",
                                "Word: ${allWords[itemIndex].title}")
                          },
                          //namedRoute: "/wordDetail"),
                        ))
                : const CircularProgressIndicator(),
      ),
    );
  }
}

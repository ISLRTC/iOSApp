import 'package:flutter/material.dart';
import 'package:islrtc/components/AppScaffold.dart';
import 'package:islrtc/components/Common.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/singleton.dart';
import 'package:islrtc/infra/word_model.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  Future<List<ISLRTCWord>> getWords(BuildContext context) async {
    String jsonCode =
        await DefaultAssetBundle.of(context).loadString(DATABASE_PATH);

    if (Singleton().listOfWords.isEmpty) {
      List<ISLRTCWord> words = ISLRTCWordFromJson(jsonCode);
      if (words.isNotEmpty) {
        Singleton().setWords(words);
        return Future.value(words);
      } else {
        return Future.error(
            "No words found. Please reinstall the App from the playstore.");
      }
    }

    return Future.value(Singleton().listOfWords);
  }

  List<Widget> renderPage(BuildContext context) {
    List<Widget> output = [];

    output.add(Common().emptySpace(height: 20));
    output.add(const Image(
      image: AssetImage("assets/signLang.jpeg"),
    ));
    output.add(Common().emptySpace(height: 20));
    output.add(Labels().title(data: "Indian Sign Language Dictionary"));
    output.add(Common().emptySpace(height: 100));
    output.add(Labels().heading(data: "Choose Your Language"));
    output.add(Common().emptySpace(height: 20));
    output.add(Common().filledButtonGroup(
      data: [Languages.english.name, Languages.hindi.name],
      onClick: (itemIndex) => {
        getWords(context)
            .then((value) => {
                  Singleton().setLanguage(Languages.values[itemIndex]),
                  Navigator.pushNamed(context, "/categories"),
                })
            .catchError((onError) => {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Text("Oops! Your app version is incorrect."),
                      content: Text(
                          "Please uninstall and install a fresh copy of this app from Playstore"),
                    ),
                  )
                })
      },
    ));
    output.add(Common().emptySpace(height: 100));
    output.add(Common().textButton(
        onClick: (itemIndex) => {Navigator.pushNamed(context, "/about")},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.info_outline_rounded), Text(" About us")],
        )));
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: renderPage(context),
        ),
      ),
    ));
  }
}

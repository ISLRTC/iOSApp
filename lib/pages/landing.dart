import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/components/AppScaffold.dart';
import 'package:islrtc/components/Common.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/singleton.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

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
        Singleton().setLanguage(Languages.values[itemIndex]),
        Navigator.pushNamed(context, "/categories"),
        print(Singleton().currentLanguage.name),
      },
    ));
    output.add(Common().emptySpace(height: 100));
    output.add(Common().textButton(
        onClick: (itemIndex) => {print(itemIndex)},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.info_outline_rounded), Text(" About us")],
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

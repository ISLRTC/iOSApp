import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/components/AppScaffold.dart';
import 'package:islrtc/components/Common.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/appUtils.dart';

class AboutSection {
  String? title;
  String? description;

  AboutSection(this.title, this.description);
  factory AboutSection.fromJson(dynamic json) {
    return AboutSection(json["title"], json["description"]);
  }
}

class About extends StatelessWidget {
  const About({super.key});

  Future<List<AboutSection>> loadAboutUs(BuildContext context) async {
    String jsonCode = await DefaultAssetBundle.of(context)
        .loadString("assets/data/about.json");

    final data = jsonDecode(jsonCode);
    List<AboutSection> temp = List<AboutSection>.from(
        data["sections"].map((model) => AboutSection.fromJson(model)));

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: true,
      pageTitle: "About",
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              initialData: [],
              future: loadAboutUs(context),
              builder: (context, snapshot) => ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done
                      ? Common()
                          .aboutUsSectionTile(section: snapshot.data![index])
                      : const CircularProgressIndicator()),
            ),
          ),
          // SizedBox(
          //     child: Common().filledButton(
          //   text: "Feedback",
          //   onClick: (index) =>
          //       AppUtils().launchUrlInBrowser("https://ww-hub.com"),
          // ))
        ],
      ),
    );
  }
}

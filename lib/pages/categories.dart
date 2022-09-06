import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/infra/singleton.dart';

import '../components/AppScaffold.dart';
import '../components/Common.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  List<String> allCategories = [];

  Future<List<String>> getCategories(BuildContext context) async {
    String jsonCode = await DefaultAssetBundle.of(context)
        .loadString("assets/data/categories.json");

    final data = jsonDecode(jsonCode);
    allCategories = List<String>.from(data["categories"]);

    return allCategories;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        pageTitle: "Categories",
        body: Column(
          children: [
            Common().searchBox(),
            Common().emptySpace(),
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
                                  print(itemIndex),
                                  Singleton()
                                      .setCategory(allCategories[itemIndex]),
                                  Navigator.pushNamed(context, "/words")
                                },
                              )
                          //ListTile(title: Text(snapshot.data![index])),
                          )
                      : const CircularProgressIndicator()),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:islrtc/components/AppScaffold.dart';
import 'package:islrtc/components/Common.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/localstorage.dart';

import '../infra/singleton.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});
  final myFavoriteWords = LocalStorage().allFavoriteWords();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        showAppBar: true,
        pageTitle: "My Favorites",
        hideAppBarActionButtons: const [1],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
                    initialData: const [],
                    future: LocalStorage().allFavoriteWords(),
                    builder: (context, snapshot) => snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => Common().listTile(
                              title: snapshot.data![index].title ?? "",
                              icon: const Icon(Icons.chevron_right_rounded),
                              index: index,
                              onClick: (index) => {
                                Singleton().setWord(snapshot.data![index]),
                                Navigator.pushNamed(context, "/wordDetail")
                              },
                            ),
                          )
                        : Labels().label(data: "No data to show")))
          ],
        ));
  }
}

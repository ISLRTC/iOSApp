import 'package:flutter/material.dart';

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
  final _selectedLanguage = Singleton().currentLanguage.name;
  final _selectedCategory = Singleton().selectedCategory;
  final _words = Singleton().listOfWords;

  void setSearchText(String text) {
    setState(() {
      _searchText = text.toLowerCase();
    });
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
                future: ISLRTCWordUtils.searchWord(
                    _searchText, _selectedLanguage, _selectedCategory, _words),
                builder: (context, snapshot) => snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => snapshot.hasData
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

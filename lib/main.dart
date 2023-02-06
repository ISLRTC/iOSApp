import 'package:flutter/material.dart';
import 'package:islrtc/infra/appTheme.dart';
import 'package:islrtc/pages/about.dart';
import 'package:islrtc/pages/categories.dart';
import 'package:islrtc/pages/favorites.dart';
import 'package:islrtc/pages/landing.dart';
import 'package:islrtc/pages/search.dart';
import 'package:islrtc/pages/word-detail.dart';
import 'package:islrtc/pages/words.dart';

void main() {
  runApp(const ISLRTCApp());
}

class ISLRTCApp extends StatelessWidget {
  const ISLRTCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: "/",
      routes: {
        "/": (context) => const Landing(),
        "/categories": (context) => Categories(),
        "/words": (context) => Words(),
        "/wordDetail": (context) => const WordDetail(),
        "/about": (context) => const About(),
        "/search": (context) => const Search(),
        "/favorites": (context) => Favorites(),
      },
    );
  }
}

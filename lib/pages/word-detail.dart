import 'package:flutter/material.dart';
import 'package:islrtc/components/AppScaffold.dart';
import 'package:islrtc/components/Common.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/localstorage.dart';
import 'package:islrtc/infra/singleton.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WordDetail extends StatefulWidget {
  const WordDetail({super.key});

  @override
  State<WordDetail> createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: Singleton().selectedWord.url ?? "",
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: true,
          loop: true,
          enableCaption: false),
    );

    super.initState();
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    // subject is optional but it will be used
    // only when sharing content over email
    await Share.share("https://youtube.com/${Singleton().selectedWord.url!}",
        subject: "Word: ${Singleton().selectedWord.title!}",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Future<Widget> renderFavoritesButton() async {
    LocalStorage _localStorage = LocalStorage();
    String key = Singleton().selectedWord.title ?? "";
    return _localStorage.isInFavorites(key: key).then((value) => value
        ? Common().btnRemoveFromFavorites(
            context: context,
            onClick: () => {
              setState(
                () => {},
              )
            },
          )
        : Common().btnAddToFavorites(
            context: context,
            onClick: () => {
              setState(
                () => {},
              )
            },
          ));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: true,
      pageTitle: "Explanation",
      body: Column(
        children: [
          Common().emptySpace(),
          Labels().heading(data: Singleton().selectedWord.title ?? ""),
          Common().emptySpace(height: 30),
          YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
          Common().emptySpace(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder(
                future: renderFavoritesButton(),
                builder: (context, snapshot) => snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done
                    ? snapshot.data!
                    : Container(),
              ),
              Common().textButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share_rounded),
                    Common().emptySpace(),
                    const Text("Share")
                  ],
                ),
                onClick: (index) => _onShare(context),
              )
            ],
          )
        ],
      ),
    );
  }
}

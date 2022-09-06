import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:islrtc/components/Common.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final bool enableSafeArea;
  final bool includeBottomInSafeArea;
  final bool showAppBar;
  final String pageTitle;

  const AppScaffold(
      {super.key,
      this.body,
      this.enableSafeArea = false,
      this.includeBottomInSafeArea = true,
      this.showAppBar = false,
      this.pageTitle = ""});

  Widget renderChild() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: body ?? const Text("Body not specified"),
    );
  }

  Widget renderBase(BuildContext context) {
    if (enableSafeArea) {
      return SafeArea(
          bottom: includeBottomInSafeArea,
          child: Scaffold(
            appBar: showAppBar
                ? Common().appBar(title: pageTitle, context: context)
                : null,
            body: renderChild(),
          ));
    } else {
      return Scaffold(
        appBar: showAppBar
            ? Common().appBar(title: pageTitle, context: context)
            : null,
        body: renderChild(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return renderBase(context);
  }
}

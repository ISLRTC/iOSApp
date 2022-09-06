import 'package:flutter/material.dart';
import 'package:islrtc/components/Labels.dart';
import 'package:islrtc/infra/constants.dart';
import 'package:islrtc/infra/singleton.dart';

class Common {
  static const String placeHolder = "Placeholder";
  static const List<String> placeHolderList = ["Placeholder"];
  Widget emptySpace({double height = 10}) {
    return SizedBox(
      height: height,
    );
  }

  Widget textButton(
      {String text = placeHolder,
      Widget? child,
      Function(int)? onClick,
      Color textColor = Colors.blue,
      FontSizes textSize = FontSizes.regular,
      int index = 0}) {
    return InkWell(
      onTap: () => {onClick?.call(index)},
      child: TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(textColor),
            textStyle:
                MaterialStateProperty.all(TextStyle(fontSize: textSize.size))),
        onPressed: () => {onClick?.call(index)},
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: child ?? Text(text.toTitleCase())),
      ),
    );
  }

  Widget filledButton(
      {String text = placeHolder,
      Widget? child,
      Function(int)? onClick,
      Color color = Colors.blue,
      Color textColor = Colors.white,
      FontSizes textSize = FontSizes.regular,
      int index = 0}) {
    return InkWell(
        onTap: () => {onClick?.call(index)},
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(Shadows.none.size),
              backgroundColor: MaterialStateProperty.all(color),
              foregroundColor: MaterialStateProperty.all(textColor),
              textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: textSize.size))),
          onPressed: () => {onClick?.call(index)},
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: child ?? Text(text.toTitleCase())),
        ));
  }

  Widget raisedButton(
      {String text = placeHolder,
      Widget? child,
      Function(int)? onClick,
      Shadows shadow = Shadows.sm,
      Color color = Colors.blue,
      Color textColor = Colors.white,
      FontSizes textSize = FontSizes.regular,
      int index = 0}) {
    return InkWell(
        onTap: () => {onClick?.call(index)},
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(shadow.size),
              backgroundColor: MaterialStateProperty.all(color),
              foregroundColor: MaterialStateProperty.all(textColor),
              textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: textSize.size))),
          onPressed: () => {onClick?.call(index)},
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: child ?? Text(text.toTitleCase())),
        ));
  }

  Widget raisedButtonGroup(
      {List<String> data = placeHolderList, Function(int)? onClick}) {
    List<Widget> generateButtons() {
      List<Widget> output = [];

      int index = 0;
      for (var element in data) {
        output.add(raisedButton(
            index: index,
            onClick: onClick,
            text: element,
            color: (index == 0
                ? AppColors.primary.color
                : AppColors.secondary.color),
            shadow: (index == 0 ? Shadows.lg : Shadows.none)));

        index++;
      }

      return output;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: generateButtons(),
    );
  }

  Widget buttonGroup(
      {List<String> data = placeHolderList, Function(int)? onClick}) {
    List<Widget> generateButtons() {
      List<Widget> output = [];

      int index = 0;
      for (var element in data) {
        output.add(textButton(
          index: index,
          onClick: onClick,
          text: element,
        ));

        index++;
      }

      return output;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: generateButtons(),
    );
  }

  Widget filledButtonGroup(
      {List<String> data = placeHolderList, Function(int)? onClick}) {
    List<Widget> generateButtons() {
      List<Widget> output = [];

      int index = 0;
      for (var element in data) {
        output.add(filledButton(
            index: index,
            onClick: onClick,
            text: element,
            color: AppColors.secondary.color,
            textColor: AppColors.dark.color));

        index++;
      }

      return output;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: generateButtons(),
    );
  }

  Widget searchBox() {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Search Words:',
      ),
    );
  }

  Widget backButton({BuildContext? context}) {
    return InkWell(
      onTap: () => {Navigator.pop(context!)},
      child: IconButton(
        icon: const Icon(Icons.chevron_left_rounded, size: 40),
        color: AppColors.primary.color,
        tooltip: 'Go back',
        onPressed: () {
          Navigator.pop(context!);
        },
      ),
    );
  }

  Widget favoritesButton({BuildContext? context}) {
    return InkWell(
      onTap: () => {Navigator.pop(context!)},
      child: IconButton(
        icon: const Icon(Icons.star_border, size: 30),
        color: AppColors.primary.color,
        tooltip: 'My favorites',
        onPressed: () {
          Navigator.pop(context!);
        },
      ),
    );
  }

  PreferredSizeWidget appBar({String title = "", BuildContext? context}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Labels().title(data: title, textColor: AppColors.primary),
      toolbarHeight: 50,
      leading: backButton(context: context),
      actions: [favoritesButton(context: context)],
    );
  }

  Widget listTile(
      {String title = "",
      Icon icon = const Icon(Icons.circle),
      int index = 0,
      //String namedRoute = "/",
      //BuildContext? context,
      Function(int)? onClick}) {
    return Card(
      color: Colors.brown.shade100,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: Shadows.sm.size,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        onTap: (() => onClick!(index)),
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Labels().title(data: title, textColor: AppColors.dark),
                trailing: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:islrtc/infra/constants.dart';

class Labels {
  Widget title({String data = "Title", AppColors textColor = AppColors.dark}) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: "Poppins-Bold", fontSize: 16, color: textColor.color),
    );
  }

  Widget heading(
      {String data = "Heading", AppColors textColor = AppColors.dark}) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: "Poppins-Bold",
          fontSize: 24,
          height: 1.5,
          color: textColor.color),
    );
  }
}

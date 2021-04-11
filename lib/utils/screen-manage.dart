
import 'package:flutter/cupertino.dart';

class ScreenManage {
  static double height;
  static double width;

  static void init(BuildContext context) {
    final data = MediaQuery.of(context);
    height= data.size.height;
    width = data.size.width;
  }
}
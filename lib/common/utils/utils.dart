import 'package:flutter/material.dart';

class MyUtils {

  static bool isDark(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getBackgroundColor(BuildContext context){
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color getDialogBackgroundColor(BuildContext context){
    return Theme.of(context).canvasColor;
  }

  static Color getDarkColor(BuildContext context, Color darkColor){
    return isDark(context) ? darkColor : null;
  }

}
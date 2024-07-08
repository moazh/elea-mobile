import 'package:flutter/material.dart';

class AppNavigator {
  static toBack({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}

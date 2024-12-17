import 'package:flutter/material.dart';

class BottomBarModel {
  String label;
  String iconData;
  int index;
  Widget page;

  String get icon => iconData;

  Text get titleForAppBar => Text(label);

  BottomBarModel(
      {required this.iconData,
      required this.label,
      required this.page,
      required this.index});
}

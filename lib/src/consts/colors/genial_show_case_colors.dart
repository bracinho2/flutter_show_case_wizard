import 'package:flutter/material.dart';

enum GenialShowCaseColors {
  overlay(Color(0xff050922)),
  enphasis(Color(0xffffffff)),
  toolTip(Color(0xff050922)),
  toolTipText(Color(0xffFAFBFF)),
  backIndicator(Color(0xffFAFBFF)),
  frontIndicator(Color(0xfffafbff)),
  transparent(Colors.transparent);

  final Color color;
  const GenialShowCaseColors(
    this.color,
  );
}

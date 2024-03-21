import 'package:flutter/material.dart';

/// This enum defines all the used colors into this micro app.
/// All the colors used are in this list.

enum GenialShowCaseColors {
  overlay(Color(0xff050922)),
  enphasis(Color(0xffd9d9d9)),
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

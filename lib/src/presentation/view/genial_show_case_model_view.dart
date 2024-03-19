import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenialShowCaseViewModel {
  GenialShowCaseViewModel._();

  static final GenialShowCaseViewModel _instance = GenialShowCaseViewModel._();

  static GenialShowCaseViewModel get instance {
    return _instance;
  }

  ValueNotifier pageNumber = ValueNotifier<int>(0);

  void nextPage({
    required int page,
  }) {
    pageNumber.value = page;
  }
}

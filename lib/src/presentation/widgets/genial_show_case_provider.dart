import 'package:flutter/material.dart';

class GenialShowCaseProvider extends InheritedNotifier<GenialShowCaseNotifier> {
  const GenialShowCaseProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static GenialShowCaseNotifier show(BuildContext context) {
    return context
        .findAncestorWidgetOfExactType<GenialShowCaseProvider>()!
        .notifier!;
  }

  static GenialShowCaseNotifier watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GenialShowCaseProvider>()!
        .notifier!;
  }
}

class GenialShowCaseNotifier extends ChangeNotifier {
  GenialShowCaseNotifier({
    required this.keys,
    required this.activeShowCase,
    required this.autoPlayDelay,
  });
  List<GlobalKey> keys;
  int activeShowCase;
  Duration autoPlayDelay;

  void setActiveShowCase(int value) {
    activeShowCase = value;
    notifyListeners();
  }

  void setKeys(List<GlobalKey> values) {
    keys = values;
    notifyListeners();
  }

  void setAutoPlayDelay(Duration value) {
    autoPlayDelay = value;
    notifyListeners();
  }
}

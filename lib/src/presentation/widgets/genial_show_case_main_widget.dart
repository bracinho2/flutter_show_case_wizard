import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_show_case_model_view.dart';
import 'package:showcaseview/showcaseview.dart';

class GenialShowCaseMainWidget extends StatefulWidget {
  const GenialShowCaseMainWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GenialShowCaseMainWidget> createState() =>
      _GenialShowCaseMainWidgetState();
}

class _GenialShowCaseMainWidgetState extends State<GenialShowCaseMainWidget> {
  Widget get _child => widget.child;
  GenialShowCaseViewModel get _viewModel => GenialShowCaseViewModel.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
          _viewModel.nextPage(page: index!);
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
          if (index == 4) {}
        },
        autoPlayDelay: const Duration(seconds: 2),
        onFinish: () {},
        blurValue: 0,
        builder: Builder(builder: (context) => _child),
      ),
    );
  }
}

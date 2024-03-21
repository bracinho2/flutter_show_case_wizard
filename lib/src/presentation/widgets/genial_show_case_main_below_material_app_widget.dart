import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_indicator_view_model.dart';
import 'package:showcaseview/showcaseview.dart';

class GenialShowCaseMainBelowMaterialAppWidget extends StatefulWidget {
  const GenialShowCaseMainBelowMaterialAppWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GenialShowCaseMainBelowMaterialAppWidget> createState() =>
      _GenialShowCaseMainBelowMaterialAppWidgetState();
}

class _GenialShowCaseMainBelowMaterialAppWidgetState
    extends State<GenialShowCaseMainBelowMaterialAppWidget> {
  Widget get _child => widget.child;
  GenialIndicatorViewModel get _viewModel =>
      Modular.get<GenialIndicatorViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
          _viewModel.showWidget(index!);
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
          if (index == 4) {}
        },
        autoPlayDelay: const Duration(seconds: 2),
        onFinish: () {},
        blurValue: 0,
        builder: Builder(
          builder: (context) => _child,
        ),
      ),
    );
  }
}

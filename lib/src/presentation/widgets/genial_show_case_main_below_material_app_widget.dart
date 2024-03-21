import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_show_case_wizard/src/presentation/enum/genial_show_case_page_location.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_indicator_view_model.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_show_case_view_model.dart';
import 'package:showcaseview/showcaseview.dart';

///This widget displays the Show case from app.
///
/// Because the ShowCase Package requires a context, we need call it just below
/// the MaterialApp in a higher position in the widget tree;
class GenialShowCaseMainBelowMaterialAppWidget extends StatefulWidget {
  ///Constructor of [GenialShowCaseMainBelowMaterialAppWidget]
  const GenialShowCaseMainBelowMaterialAppWidget({
    super.key,
    required this.child,
  });

  /// The ShowCase widget aldo has a child widget that will be displayed.
  /// However, for a ShowCase to be displayed there will be another specific
  /// widget thats controls this exhibition;
  final Widget child;

  @override
  State<GenialShowCaseMainBelowMaterialAppWidget> createState() =>
      _GenialShowCaseMainBelowMaterialAppWidgetState();
}

class _GenialShowCaseMainBelowMaterialAppWidgetState
    extends State<GenialShowCaseMainBelowMaterialAppWidget> {
  Widget get _child => widget.child;
  GenialIndicatorViewModel get _indicatorViewModel =>
      Modular.get<GenialIndicatorViewModel>();

  GenialShowCaseViewModel get _viewModel =>
      Modular.get<GenialShowCaseViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          final result = _viewModel.startShowCase(
            location: GenialShowCasePageLocation.mainPage,
          );
          if (result) {
            _indicatorViewModel.showWidget(index!);
          }
        },
        onComplete: (index, key) {
          _viewModel.stopShowCase(
              location: GenialShowCasePageLocation.mainPage);
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

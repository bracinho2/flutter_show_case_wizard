import 'package:flutter/material.dart';

import 'package:flutter_show_case_wizard/src/presentation/widgets/genial_show_case_provider.dart';
import 'package:showcaseview/showcaseview.dart';

///This widget displays the Show case from app.
///
/// Because the ShowCase Package requires a context, we need call it just below
/// the MaterialApp in a higher position in the widget tree;
class GenialWizard extends StatefulWidget {
  ///Constructor of [GenialWizard]
  const GenialWizard({
    super.key,
    required this.child,
    required this.keys,
    this.autoPlay = true,
    this.autoPlayDelay = const Duration(milliseconds: 4000),
  });

  /// The ShowCase widget aldo has a child widget that will be displayed.
  /// However, for a ShowCase to be displayed there will be another specific
  /// widget thats controls this exhibition;
  final Widget child;

  ///
  final List<GlobalKey> keys;

  ///
  final bool autoPlay;

  ///
  final Duration autoPlayDelay;

  @override
  State<GenialWizard> createState() => _GenialWizardState();
}

class _GenialWizardState extends State<GenialWizard> {
  Widget get _child => widget.child;

  @override
  Widget build(BuildContext context) {
    final genialShowCaseNotifier = GenialShowCaseNotifier(
      keys: widget.keys,
      activeShowCase: 0,
      autoPlayDelay: widget.autoPlayDelay,
    );

    return Scaffold(
      body: GenialShowCaseProvider(
        notifier: genialShowCaseNotifier,
        child: ShowCaseWidget(
          onStart: (index, key) {
            genialShowCaseNotifier.setActiveShowCase(index!);
          },
          onComplete: (index, key) {},
          autoPlayDelay: widget.autoPlayDelay,
          autoPlay: widget.autoPlay,
          onFinish: () {},
          blurValue: 0,
          builder: Builder(
            builder: (context) => _child,
          ),
        ),
      ),
    );
  }
}

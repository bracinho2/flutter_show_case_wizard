import 'package:flutter/material.dart';

import 'package:flutter_show_case_wizard/src/presentation/widgets/genial_show_case_provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../genial_show_case_keys.dart';
import 'genial_show_case_indicator.dart';

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
    required this.onFinishWizard,
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

  ///
  final Function() onFinishWizard;

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
          autoPlayDelay: widget.autoPlayDelay,
          autoPlay: widget.autoPlay,
          onFinish: widget.onFinishWizard,
          blurValue: 0,
          builder: Builder(
            builder: (context) => _GenialCommandWizard(
              child: _child,
            ),
          ),
        ),
      ),
    );
  }
}

class _GenialCommandWizard extends StatefulWidget {
  const _GenialCommandWizard({
    required this.child,
  });

  final Widget child;

  @override
  State<_GenialCommandWizard> createState() => _GenialCommandWizardState();
}

class _GenialCommandWizardState extends State<_GenialCommandWizard> {
  Widget get _child => widget.child;

  int flags = 0;
  Duration autoPlayDelay = const Duration(milliseconds: 0);
  int activeShowCase = 0;

  void nextShowCase() {
    final activeShowCase = ShowCaseWidget.of(context).activeWidgetId!;
    if (activeShowCase < flags - 1) {
      ShowCaseWidget.of(context).next();
    }
  }

  void previousShowCase() {
    final activeShowCase = ShowCaseWidget.of(context).activeWidgetId;
    if (activeShowCase != null) {
      ShowCaseWidget.of(context).previous();
    }
  }

  OverlayEntry? indicator;

  void showIndicator() {
    hideIndicator();

    final genialShowCaseNotifier = GenialShowCaseProvider.show(context);

    indicator = OverlayEntry(
      builder: (context) {
        return GenialShowCaseProvider(
            notifier: genialShowCaseNotifier,
            child: Positioned(
              top: 0,
              left: 2,
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GenialShowCaseIndicator(
                    key: ValueKey(activeShowCase),
                    leftClick: previousShowCase,
                    rightClick: nextShowCase,
                  ),
                ),
              ),
            ));
      },
    );

    Overlay.of(context).insert(indicator!);
  }

  void hideIndicator() {
    indicator?.remove();
    indicator?.dispose();
    indicator = null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase(GenialShowCaseKeys.myKeys);
      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () {
          showIndicator();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = GenialShowCaseProvider.show(context);

    flags = provider.keys.length;
    autoPlayDelay = provider.autoPlayDelay;
    activeShowCase = provider.activeShowCase;

    return _child;
  }
}

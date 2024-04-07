import 'package:flutter/material.dart';

import 'package:flutter_show_case_wizard/src/consts/colors/genial_show_case_colors.dart';

import 'genial_show_case_provider.dart';

/// Creates the flatgs to Show Case indicator.
class GenialShowCaseIndicator extends StatefulWidget {
  /// Contructor of [GenialShowCaseIndicator];
  const GenialShowCaseIndicator({
    super.key,
    this.leftClick,
    this.rightClick,
  });

  /// It is possible to insert an action into left click of the screen when the
  /// flags are displayed to move forward or backward.
  final void Function()? leftClick;

  /// It is possible to insert an action into right click of the screen when the
  /// flags are displayed to move forward or backward.
  final void Function()? rightClick;

  @override
  State<GenialShowCaseIndicator> createState() =>
      _GenialShowCaseIndicatorState();
}

class _GenialShowCaseIndicatorState extends State<GenialShowCaseIndicator>
    with TickerProviderStateMixin {
  int activeShowCase = 0;
  int oldShowcase = 0;
  int flags = 0;
  Duration autoPlayDelay = const Duration(milliseconds: 0);

  Function()? get _leftClick => widget.leftClick;
  Function()? get _rightClick => widget.rightClick;

  final _animationControllers = [];

  void onPageChanged() {
    if (oldShowcase == activeShowCase || oldShowcase != activeShowCase) {
      stopAndResetAnimation(oldShowcase);
      startAnimation(activeShowCase);
      oldShowcase = activeShowCase;
    }
  }

  void stopAndResetAnimation(int index) {
    if (index >= 0 && index < _animationControllers.length) {
      _animationControllers[index].stop();
      _animationControllers[index].reset();
    }
  }

  void startAnimation(int index) {
    if (index >= 0 && index < _animationControllers.length) {
      _animationControllers[index].forward();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context).size;

    final genialShowCaseNotifier = GenialShowCaseProvider.watch(context);

    activeShowCase = genialShowCaseNotifier.activeShowCase;
    flags = genialShowCaseNotifier.keys.length;
    autoPlayDelay = Duration(
        milliseconds:
            genialShowCaseNotifier.autoPlayDelay.inMilliseconds - 1000);

    for (int i = 0; i < flags; i++) {
      _animationControllers.add(
        AnimationController(
          vsync: this,
          duration: autoPlayDelay,
        ),
      );
    }

    onPageChanged();

    return Column(
      children: [
        SizedBox(
          height: 24,
          child: Row(
            children: List.generate(
              flags,
              (index) => AnimatedBuilder(
                animation: _animationControllers[index],
                builder: (context, child) => Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _animationControllers[index].value,
                        backgroundColor: GenialShowCaseColors
                            .backIndicator.color
                            .withOpacity(.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          GenialShowCaseColors.frontIndicator.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _leftClick,
                onLongPress: () {},
                child: Container(
                  width: mediaQueryData.width / 2,
                  color: GenialShowCaseColors.transparent.color,
                ),
              ),
              GestureDetector(
                onTap: _rightClick,
                onLongPress: () {},
                child: Container(
                  width: mediaQueryData.width / 2,
                  color: GenialShowCaseColors.transparent.color,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

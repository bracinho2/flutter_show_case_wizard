import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_show_case_wizard/src/consts/colors/genial_show_case_colors.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_indicator_view_model.dart';
import 'package:showcaseview/showcaseview.dart';

class GenialShowCaseIndicatorFlagWidget extends StatefulWidget {
  const GenialShowCaseIndicatorFlagWidget({
    super.key,
    required this.flags,
    required this.duration,
    this.leftClick,
    this.rightClick,
  });

  final int flags;
  final int duration;
  final void Function()? leftClick;
  final void Function()? rightClick;

  @override
  State<GenialShowCaseIndicatorFlagWidget> createState() =>
      _GenialShowCaseIndicatorFlagWidgetState();
}

class _GenialShowCaseIndicatorFlagWidgetState
    extends State<GenialShowCaseIndicatorFlagWidget>
    with TickerProviderStateMixin {
  final cubit = Modular.get<GenialIndicatorViewModel>();

  int get _flags => widget.flags;
  int get _duration => widget.duration;

  Function()? get _leftClick => widget.leftClick;
  Function()? get _rightClick => widget.rightClick;

  final _animationControllers = [];
  int _currentPageIndex = 0;

  void _startAnimation() {
    _animationControllers[_currentPageIndex].stop();
    _animationControllers[_currentPageIndex].reset();
    _animationControllers[_currentPageIndex].forward();
  }

  @override
  void initState() {
    super.initState();
    _currentPageIndex = cubit.state;

    for (int i = 0; i < _flags; i++) {
      _animationControllers.add(
        AnimationController(
          vsync: this,
          duration: Duration(seconds: _duration),
        ),
      );
    }
    _startAnimation();
  }

  void _listener(
    BuildContext context,
    int index,
  ) {
    if (index > _currentPageIndex) {
      _animationControllers[_currentPageIndex].value = _duration.toDouble();
    } else {
      _animationControllers[_currentPageIndex].stop();
      _animationControllers[_currentPageIndex].reset();
    }

    _startAnimation();
  }

  void nextPage() {
    ShowCaseWidget.of(context).next();
  }

  void previusPage() {
    ShowCaseWidget.of(context).previous();
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
    return BlocConsumer<GenialIndicatorViewModel, int>(
      bloc: cubit,
      listener: _listener,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 24,
              child: Row(
                children: List.generate(
                  _flags,
                  (index) => AnimatedBuilder(
                    animation: _animationControllers[index],
                    builder: (context, child) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
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
                    child: Container(
                      width: 50,
                      color: GenialShowCaseColors.transparent.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: _rightClick,
                    child: Container(
                      width: 50,
                      color: GenialShowCaseColors.transparent.color,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

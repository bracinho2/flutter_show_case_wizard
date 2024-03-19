import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_show_case_model_view.dart';

import 'package:showcaseview/showcaseview.dart';

class ShowCaseIndicatorWidget extends StatefulWidget {
  const ShowCaseIndicatorWidget({
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
  State<ShowCaseIndicatorWidget> createState() =>
      _ShowCaseIndicatorWidgetState();
}

class _ShowCaseIndicatorWidgetState extends State<ShowCaseIndicatorWidget>
    with TickerProviderStateMixin {
  final _viewModel = GenialShowCaseViewModel.instance;

  int get _flags => widget.flags;
  int get _duration => widget.duration;
  Function()? get _leftClick => widget.leftClick;
  Function()? get _rightClick => widget.rightClick;

  final _animationControllers = [];
  int _currentPageIndex = 0;
  late Timer _timer;

  void _startAnimation() {
    _animationControllers[_currentPageIndex].stop();
    _animationControllers[_currentPageIndex].reset();
    _animationControllers[_currentPageIndex].forward();
    _timer = Timer(Duration(seconds: _duration), () {});
  }

  void _onPageChanged(int index) {
    if (index > _currentPageIndex) {
      _animationControllers[_currentPageIndex].value = _duration.toDouble();
      _timer.cancel();
    } else {
      _timer.cancel();
      _animationControllers[_currentPageIndex].stop();
      _animationControllers[_currentPageIndex].reset();
    }

    _startAnimation();
  }

  void _listener() {
    _onPageChanged(_viewModel.pageNumber.value);
  }

  @override
  void initState() {
    _viewModel.pageNumber.addListener(_listener);
    _currentPageIndex = _viewModel.pageNumber.value;
    super.initState();
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

  void nextPage() {
    ShowCaseWidget.of(context).next();
  }

  void previusPage() {
    ShowCaseWidget.of(context).previous();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    _viewModel.pageNumber.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _animationControllers[index].value,
                        backgroundColor: Colors.amber,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
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
                  color: Colors.amber,
                ),
              ),
              GestureDetector(
                onTap: _rightClick,
                child: Container(
                  width: 50,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

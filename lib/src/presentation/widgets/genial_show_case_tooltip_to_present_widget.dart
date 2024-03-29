import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_show_case_wizard/src/consts/colors/genial_show_case_colors.dart';
import 'package:flutter_show_case_wizard/src/presentation/enum/genial_show_case_tooltip_direction.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_show_case_view_model.dart';

import 'package:showcaseview/showcaseview.dart';

import '../enum/genial_show_case_page_location.dart';
import 'genial_show_case_indicator_flag_widget.dart';

/// This widget display the Showcase in your child widget.
/// It's necessary configure the local cache to know it's the first
/// time to show all show cases and after disable it.

class GenialShowCaseToPresentWidget extends StatelessWidget {
  /// Constructor of [GenialShowCaseToPresentWidget]
  const GenialShowCaseToPresentWidget({
    super.key,
    required this.heightFromWidget,
    required this.widthFromWidget,
    required this.toolTipMessage,
    required this.child,
    required this.childKey,
    this.movingAnimationDuration = Duration.zero,
    required this.direction,
    this.toolTipBorderRadius = const Radius.circular(10),
    this.flags = 0,
    this.leftClick,
    this.rightClick,
  });

  final double heightFromWidget;
  final double widthFromWidget;
  final String toolTipMessage;
  final Widget child;
  final GlobalKey childKey;
  final Duration movingAnimationDuration;
  final GenialShowCaseToolTipDirection direction;
  final Radius toolTipBorderRadius;
  final int flags;
  final void Function()? leftClick;
  final void Function()? rightClick;

  @override
  Widget build(BuildContext context) {
    final viewModel = Modular.get<GenialShowCaseViewModel>();

    TooltipPosition getPosition({
      required GenialShowCaseToolTipDirection position,
    }) {
      final result = switch (position) {
        GenialShowCaseToolTipDirection.topLeft => TooltipPosition.top,
        GenialShowCaseToolTipDirection.topRight => TooltipPosition.top,
        GenialShowCaseToolTipDirection.bottomLeft => TooltipPosition.bottom,
        GenialShowCaseToolTipDirection.bottomRight => TooltipPosition.bottom,
      };
      return result;
    }

    return Visibility(
      replacement: child,
      visible: viewModel.startShowCase(
        location: GenialShowCasePageLocation.mainPage,
      ),
      child: Showcase.withWidget(
        topPageShowCaseIndicator: flags == 0
            ? null
            : GenialShowCaseIndicatorFlagWidget(
                flags: flags,
                duration: 2,
                leftClick: leftClick,
                rightClick: rightClick,
              ),
        overlayColor: GenialShowCaseColors.overlay.color,
        overlayOpacity: .82,
        key: childKey,
        height: heightFromWidget,
        width: widthFromWidget,
        container: LegendToolTipoWidget.build(
          toolTipMessage: toolTipMessage,
          direction: direction,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
        targetPadding: const EdgeInsets.all(12),
        targetShapeBorder: const CircleBorder(),
        movingAnimationDuration: movingAnimationDuration,
        tooltipPosition: getPosition(
          position: direction,
        ),
        child: child,
      ),
    );
  }
}

class LegendToolTipoWidget extends StatelessWidget {
  const LegendToolTipoWidget._({
    required this.toolTipMessage,
    required this.direction,
    required this.toolTipBorderRadius,
  });

  final String toolTipMessage;
  final GenialShowCaseToolTipDirection direction;
  final Radius toolTipBorderRadius;

  factory LegendToolTipoWidget.build({
    required String toolTipMessage,
    required GenialShowCaseToolTipDirection direction,
    required Radius toolTipBorderRadius,
  }) {
    final result = switch (direction) {
      GenialShowCaseToolTipDirection.bottomLeft => LegendToolTipoWidget._(
          toolTipMessage: toolTipMessage,
          direction: GenialShowCaseToolTipDirection.bottomLeft,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.topLeft => LegendToolTipoWidget._(
          toolTipMessage: toolTipMessage,
          direction: GenialShowCaseToolTipDirection.topLeft,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.topRight => LegendToolTipoWidget._(
          toolTipMessage: toolTipMessage,
          direction: GenialShowCaseToolTipDirection.topRight,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.bottomRight => LegendToolTipoWidget._(
          toolTipMessage: toolTipMessage,
          direction: GenialShowCaseToolTipDirection.bottomRight,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
    };
    return result;
  }

  BorderRadius getBorderRadius({
    required GenialShowCaseToolTipDirection direction,
    required Radius toolTipBorderRadius,
  }) {
    final result = switch (direction) {
      GenialShowCaseToolTipDirection.topLeft => BorderRadius.only(
          topLeft: toolTipBorderRadius,
          topRight: toolTipBorderRadius,
          bottomRight: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.topRight => BorderRadius.only(
          topLeft: toolTipBorderRadius,
          topRight: toolTipBorderRadius,
          bottomLeft: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.bottomLeft => BorderRadius.only(
          topRight: toolTipBorderRadius,
          bottomLeft: toolTipBorderRadius,
          bottomRight: toolTipBorderRadius,
        ),
      GenialShowCaseToolTipDirection.bottomRight => BorderRadius.only(
          topLeft: toolTipBorderRadius,
          bottomLeft: toolTipBorderRadius,
          bottomRight: toolTipBorderRadius,
        ),
    };
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: GenialShowCaseColors.toolTip.color,
        borderRadius: getBorderRadius(
          direction: direction,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
      ),
      child: Text(
        toolTipMessage,
        style: TextStyle(
          color: GenialShowCaseColors.toolTipText.color,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_show_case_wizard/src/presentation/enum/genial_show_case_tooltip_direction.dart';

import 'package:showcaseview/showcaseview.dart';

class GenialShowCaseWidget extends StatelessWidget {
  const GenialShowCaseWidget({
    super.key,
    required this.heightFromWidget,
    required this.widthFromWidget,
    required this.toolTipMessage,
    required this.child,
    required this.childKey,
    this.movingAnimationDuration = Duration.zero,
    required this.direction,
    this.toolTipBorderRadius = const Radius.circular(10),
    this.topPageShowCaseIndicator,
  });

  final double heightFromWidget;
  final double widthFromWidget;
  final String toolTipMessage;
  final Widget child;
  final GlobalKey childKey;
  final Duration movingAnimationDuration;
  final GenialShowCaseToolTipDirection direction;
  final Radius toolTipBorderRadius;
  final Widget? topPageShowCaseIndicator;

  @override
  Widget build(BuildContext context) {
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

    return Showcase.withWidget(
      topPageShowCaseIndicator: topPageShowCaseIndicator,
      overlayOpacity: .3,
      key: childKey,
      height: heightFromWidget,
      width: widthFromWidget,
      container: LegendToolTipoWidget.build(
        toolTipMessage: toolTipMessage,
        direction: direction,
        toolTipBorderRadius: toolTipBorderRadius,
      ),
      targetPadding: const EdgeInsets.all(10),
      targetShapeBorder: const CircleBorder(),
      movingAnimationDuration: movingAnimationDuration,
      tooltipPosition: getPosition(
        position: direction,
      ),
      child: child,
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
        color: Colors.blueAccent,
        borderRadius: getBorderRadius(
          direction: direction,
          toolTipBorderRadius: toolTipBorderRadius,
        ),
      ),
      child: Text(
        toolTipMessage,
      ),
    );
  }
}

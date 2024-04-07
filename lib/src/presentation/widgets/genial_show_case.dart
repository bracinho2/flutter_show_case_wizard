import 'package:flutter/material.dart';
import 'package:flutter_show_case_wizard/src/consts/colors/genial_show_case_colors.dart';
import 'package:flutter_show_case_wizard/src/presentation/enum/genial_show_case_tooltip_direction.dart';
import 'package:showcaseview/showcaseview.dart';

/// This widget display the Showcase in your child widget.
/// It's necessary configure the local cache to know it's the first
/// time to show all show cases and after disable it.

class GenialShowCase extends StatefulWidget {
  /// Constructor of [GenialShowCase]
  const GenialShowCase({
    super.key,
    required this.heightFromWidget,
    required this.widthFromWidget,
    required this.toolTipMessage,
    required this.child,
    required this.childKey,
    this.movingAnimationDuration = Duration.zero,
    required this.direction,
    this.toolTipBorderRadius = const Radius.circular(10),
  });

  final double heightFromWidget;
  final double widthFromWidget;
  final String toolTipMessage;
  final Widget child;
  final GlobalKey childKey;
  final Duration movingAnimationDuration;
  final GenialShowCaseToolTipDirection direction;
  final Radius toolTipBorderRadius;

  @override
  State<GenialShowCase> createState() => _GenialShowCaseState();
}

class _GenialShowCaseState extends State<GenialShowCase> {
  int flags = 0;
  int activeShowCase = 0;
  Duration autoPlayDelay = const Duration(milliseconds: 0);

  void setInicialShowCase() {
    activeShowCase = ShowCaseWidget.of(context).activeWidgetId!;
  }

  @override
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: widget.child,
      visible: true,
      child: Showcase.withWidget(
        overlayColor: GenialShowCaseColors.overlay.color,
        overlayOpacity: .82,
        key: widget.childKey,
        height: widget.heightFromWidget,
        width: widget.widthFromWidget,
        targetBorderRadius: BorderRadius.circular(100),
        container: LegendToolTipoWidget.build(
          toolTipMessage: widget.toolTipMessage,
          direction: widget.direction,
          toolTipBorderRadius: widget.toolTipBorderRadius,
        ),
        targetPadding: const EdgeInsets.all(12),
        targetShapeBorder: const CircleBorder(),
        movingAnimationDuration: widget.movingAnimationDuration,
        tooltipPosition: getPosition(
          position: widget.direction,
        ),
        child: widget.child,
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

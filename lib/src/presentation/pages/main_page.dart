import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../enum/genial_show_case_tooltip_direction.dart';
import '../widgets/genial_show_case.dart';
import '../widgets/genial_show_case_indicator.dart';
import '../widgets/genial_show_case_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<GlobalKey> showCaseList = [];

  int flags = 0;
  Duration autoPlayDelay = const Duration(milliseconds: 0);
  int activeShowCase = 0;

  List<GlobalKey> keys = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase(showCaseList);
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
  Widget build(BuildContext context) {
    final provider = GenialShowCaseProvider.show(context);

    flags = provider.keys.length;
    autoPlayDelay = provider.autoPlayDelay;
    activeShowCase = provider.activeShowCase;
    keys = provider.keys;

    showCaseList = provider.keys;
    return Scaffold(
      appBar: AppBar(),
      body: GenialShowCase(
        heightFromWidget: 50,
        widthFromWidget: 0,
        childKey: showCaseList[0],
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.bottomLeft,
        child: const Text('Meu Texto'),
      ),
      floatingActionButton: GenialShowCase(
        heightFromWidget: 0,
        widthFromWidget: 185,
        childKey: showCaseList[1],
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.topRight,
        child: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

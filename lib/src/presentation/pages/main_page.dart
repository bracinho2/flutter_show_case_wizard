import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../enum/genial_show_case_tooltip_direction.dart';
import '../widgets/genial_show_case_tooltip_to_present_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();

  List<GlobalKey> showCaseList = [];

  @override
  void initState() {
    super.initState();
    showCaseList = [_one, _two];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([
        _one,
        _two,
      ]);
    });
  }

  void nextWidget() {
    ShowCaseWidget.of(context).next();
  }

  void previusWidget() {
    ShowCaseWidget.of(context).previous();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GenialShowCaseToPresentWidget(
        heightFromWidget: 50,
        widthFromWidget: 0,
        childKey: _one,
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.bottomLeft,
        flags: showCaseList.length,
        child: const Text('Meu Texto'),
      ),
      floatingActionButton: GenialShowCaseToPresentWidget(
        heightFromWidget: 0,
        widthFromWidget: 185,
        childKey: _two,
        flags: showCaseList.length,
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.topRight,
        leftClick: () => previusWidget(),
        rightClick: () => nextWidget(),
        child: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

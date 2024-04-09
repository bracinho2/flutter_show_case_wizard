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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = GenialShowCaseProvider.show(context);

    showCaseList = provider.keys;

    return Scaffold(
      appBar: AppBar(),
      body: GenialShowCase.build(
        heightFromWidget: 50,
        widthFromWidget: 0,
        childKey: showCaseList[0],
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.bottomLeft,
        child: const Text('Meu Texto'),
      ),
      floatingActionButton: GenialShowCase.build(
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

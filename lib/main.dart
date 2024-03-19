import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';

import 'package:flutter_show_case_wizard/genial_show_case_widget.dart';

import 'src/presentation/widgets/genial_show_case_indicator_widget.dart';
import 'src/presentation/widgets/genial_show_case_main_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genial Show Case',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenialShowCaseMainWidget(
        child: MyPage(),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({
    super.key,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
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
      body: GenialShowCaseWidget(
        heightFromWidget: 50,
        widthFromWidget: 0,
        childKey: _one,
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.bottomLeft,
        topPageShowCaseIndicator: ShowCaseIndicatorWidget(
          flags: showCaseList.length,
          duration: 2,
          leftClick: () => previusWidget(),
          rightClick: () => nextWidget(),
        ),
        child: const Text('Meu Texto'),
      ),
      floatingActionButton: GenialShowCaseWidget(
        heightFromWidget: 0,
        widthFromWidget: 185,
        childKey: _two,
        toolTipMessage: 'Minha Mensagem',
        direction: GenialShowCaseToolTipDirection.topRight,
        topPageShowCaseIndicator: ShowCaseIndicatorWidget(
          flags: showCaseList.length,
          duration: 2,
          leftClick: () => previusWidget(),
          rightClick: () => nextWidget(),
        ),
        child: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

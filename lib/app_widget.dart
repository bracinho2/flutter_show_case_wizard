import 'package:flutter/material.dart';
import 'package:flutter_show_case_wizard/src/presentation/pages/main_page.dart';
import 'src/presentation/widgets/genial_wizard.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<GlobalKey> showCaseGlobalKeys = [
      GlobalKey(),
      GlobalKey(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genial Show Case',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: GenialWizard(
        keys: showCaseGlobalKeys,
        autoPlay: true,
        child: const MainPage(),
      ),
    );
  }
}

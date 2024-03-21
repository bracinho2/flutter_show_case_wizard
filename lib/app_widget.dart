import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_show_case_wizard/src/presentation/pages/main_page.dart';
import 'package:flutter_show_case_wizard/src/presentation/view/genial_indicator_view_model.dart';

import 'src/presentation/widgets/genial_show_case_main_below_material_app_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genial Show Case',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => GenialIndicatorViewModel(),
        child: const GenialShowCaseMainBelowMaterialAppWidget(
          child: MainPage(),
        ),
      ),
    );
  }
}

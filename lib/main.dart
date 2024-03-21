import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_show_case_wizard/app_module.dart';
import 'package:flutter_show_case_wizard/app_widget.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

import 'package:flutter_modular/flutter_modular.dart';
import 'src/presentation/view/genial_indicator_view_model.dart';
import 'src/presentation/view/genial_show_case_view_model.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => GenialShowCaseViewModel(),
        ),
        Bind.lazySingleton(
          (i) => GenialIndicatorViewModel(),
        ),
      ];
}

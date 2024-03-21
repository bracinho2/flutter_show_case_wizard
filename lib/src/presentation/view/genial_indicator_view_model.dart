import 'package:flutter_bloc/flutter_bloc.dart';

/// This viewModel controls the indicators to display the correct flag
/// with the correct widget that's show case;
class GenialIndicatorViewModel extends Cubit<int> {
  GenialIndicatorViewModel() : super(0);

  void showWidget(int index) {
    emit(index);
  }
}

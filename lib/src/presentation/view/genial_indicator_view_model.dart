import 'package:flutter_bloc/flutter_bloc.dart';

class GenialIndicatorViewModel extends Cubit<int> {
  GenialIndicatorViewModel() : super(0);

  void showWidget(int index) {
    emit(index);
  }
}

import '../enum/genial_show_case_page_location.dart';

class GenialShowCaseViewModel {
  bool startShowCase({
    required GenialShowCasePageLocation location,
  }) {
    //TODO: check cache to start show case;
    return true;
  }

  void stopShowCase({
    required GenialShowCasePageLocation location,
  }) {
    //TODO: save decision in cache to stop show case after first show to user;
  }
}

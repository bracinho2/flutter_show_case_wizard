/// This enum informs on which pages the show case will be displayed and allows
/// searching for information in the local cache whether or not the user
/// has already viewed the show case in question.
///
enum GenialShowCasePageLocation {
  mainPage('mainPage');

  final String page;
  const GenialShowCasePageLocation(
    this.page,
  );
}

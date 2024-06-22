import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;

  void setAppLocale(Locale newLocale) {
    _appLocale = newLocale;
    notifyListeners();
  }
}
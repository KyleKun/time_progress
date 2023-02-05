import 'package:flutter/material.dart';
import 'package:time_progress/theme.dart';

import 'constants.dart';
import 'shared_prefs.dart';

class PreferencesProvider extends ChangeNotifier {
  bool showCurrentDate =
      SharedPrefs.getBool(Constants.kPrefsShowCurrentDate) ?? true;
  bool swapBarsOrder =
      SharedPrefs.getBool(Constants.kPrefsSwapBarsOrder) ?? false;
  bool showPercentageDecimals =
      SharedPrefs.getBool(Constants.kPrefsShowPercentageDecimals) ?? false;

  void setShowCurrentDate(bool value) {
    SharedPrefs.putBool(Constants.kPrefsShowCurrentDate, value);
    showCurrentDate = value;
    notifyListeners();
  }

  void setSwapBarsOrder(bool value) {
    SharedPrefs.putBool(Constants.kPrefsSwapBarsOrder, value);
    swapBarsOrder = value;
    notifyListeners();
  }

  void setShowPercentageDecimals(bool value) {
    SharedPrefs.putBool(Constants.kPrefsShowPercentageDecimals, value);
    showPercentageDecimals = value;
    notifyListeners();
  }
}

class BackgroundProvider extends ChangeNotifier {
  String backgroundImagePath =
      SharedPrefs.getString(Constants.kPrefsBackgroundImage);

  void setBackgroundImage(String value) {
    SharedPrefs.putString(Constants.kPrefsBackgroundImage, value);
    backgroundImagePath = value;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  int themeId = SharedPrefs.getInt(Constants.kPrefsTheme) ?? 0;

  ThemeData getTheme() {
    return AppThemes.themes[themeId];
  }

  void changeTheme() {
    final value = (themeId == AppThemes.themes.length - 1) ? 0 : themeId + 1;
    SharedPrefs.putInt(Constants.kPrefsTheme, value);
    themeId = value;
    notifyListeners();
  }
}

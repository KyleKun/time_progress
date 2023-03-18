import 'package:flutter/material.dart';
import 'package:time_progress/theme.dart';

import 'constants.dart';
import 'shared_prefs.dart';

class PreferencesProvider extends ChangeNotifier {
  int workingDayStartHour =
      SharedPrefs.getInt(Constants.kPrefsWorkingDayStartHour) ?? 8;
  int workingDayStartMinutes =
      SharedPrefs.getInt(Constants.kPrefsWorkingDayStartMinutes) ?? 0;
  int workingDayEndHour =
      SharedPrefs.getInt(Constants.kPrefsWorkingDayEndHour) ?? 17;
  int workingDayEndMinutes =
      SharedPrefs.getInt(Constants.kPrefsWorkingDayEndMinutes) ?? 0;

  bool showCurrentDate =
      SharedPrefs.getBool(Constants.kPrefsShowCurrentDate) ?? true;
  bool swapBarsOrder =
      SharedPrefs.getBool(Constants.kPrefsSwapBarsOrder) ?? false;
  bool showPercentageDecimals =
      SharedPrefs.getBool(Constants.kPrefsShowPercentageDecimals) ?? false;
  bool showWorkingDayBar =
      SharedPrefs.getBool(Constants.kPrefsShowWorkingDayBar) ?? true;

  double mainCardOpacity =
      SharedPrefs.getDouble(Constants.kPrefsMainCardOpacity) ?? 0.9;

  void setMainCardOpacity(double value) {
    SharedPrefs.putDouble(Constants.kPrefsMainCardOpacity, value);
    mainCardOpacity = value;
    notifyListeners();
  }

  void setWorkingDayStartHour(int value) {
    SharedPrefs.putInt(Constants.kPrefsWorkingDayStartHour, value);
    workingDayStartHour = value;
    notifyListeners();
  }

  void setWorkingDayStartMinutes(int value) {
    SharedPrefs.putInt(Constants.kPrefsWorkingDayStartMinutes, value);
    workingDayStartMinutes = value;
    notifyListeners();
  }

  void setWorkingDayEndHour(int value) {
    SharedPrefs.putInt(Constants.kPrefsWorkingDayEndHour, value);
    workingDayEndHour = value;
    notifyListeners();
  }

  void setWorkingDayEndMinutes(int value) {
    SharedPrefs.putInt(Constants.kPrefsWorkingDayEndMinutes, value);
    workingDayEndMinutes = value;
    notifyListeners();
  }

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

  void setShowWorkingDayBar(bool value) {
    SharedPrefs.putBool(Constants.kPrefsShowWorkingDayBar, value);
    showWorkingDayBar = value;
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

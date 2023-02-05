import 'package:intl/intl.dart';

class TimeUtils {
  static String getCurrentDateString() {
    final now = DateTime.now();
    final formatter = DateFormat('E, MMMM d');
    return formatter.format(now);
  }

  static double getYearPercentage() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31);
    final duration = endOfYear.difference(startOfYear).inSeconds;
    final elapsed = now.difference(startOfYear).inSeconds;
    return elapsed / duration;
  }

  static double getMonthPercentage() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = now.month < 12
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);
    final duration = endOfMonth.difference(startOfMonth).inSeconds;
    final elapsed = now.difference(startOfMonth).inSeconds;
    return elapsed / duration;
  }

  static double getDayPercentage() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    final duration = endOfDay.difference(startOfDay).inSeconds;
    final elapsed = now.difference(startOfDay).inSeconds;
    return elapsed / duration;
  }
}

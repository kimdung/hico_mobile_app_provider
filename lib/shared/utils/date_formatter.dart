import 'package:intl/intl.dart';

import '../constants/common.dart';

class DateFormatter {
  static String formatDate(DateTime? date, {bool toLocal = true}) {
    if (date == null) {
      return '';
    }
    final formatter = DateFormat(CommonConstants.dateFormat);
    return formatter.format(toLocalDate(date, toLocal));
  }

  static String formatTime(DateTime? date, {bool toLocal = true}) {
    if (date == null) {
      return '';
    }
    final formatter = DateFormat(CommonConstants.timeFormat);
    return formatter.format(toLocalDate(date, toLocal));
  }

  static DateTime toLocalDate(DateTime date, bool toLocal) {
    return toLocal ? date.toLocal() : date;
  }

  static DateTime formatToDate(String inputString) {
    final formatter = DateFormat(CommonConstants.dateFormat);
    return formatter.parse(inputString).toLocal();
  }
}
